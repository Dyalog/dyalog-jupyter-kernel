import json
import os
import socket
import sys
import time
import subprocess
import re
import html

from collections import deque


from ipykernel.kernelbase import Kernel
from dyalog_kernel import __version__
from notebook.services.config import ConfigManager

if sys.platform.lower().startswith('win'):
    from winreg import *

handShake1 = b'\x00\x00\x00\x1cRIDESupportedProtocols=2'
handShake2 = b'\x00\x00\x00\x17RIDEUsingProtocol=2'

BUFFER_SIZE = 1024
DYALOG_HOST = '127.0.0.1'
DYALOG_PORT = 4502
TCP_TIMEOUT = 0.1

#_increment for port. To find first available
_port = DYALOG_PORT

#no of sec waiting for initial RIDE handshake. Slower systems should be greater no. of sec, to give dyalog a chance to start
RIDE_INIT_CONNECT_TIME_OUT = 3  #seconds

SUSPEND = False   # Can be set by %suspend on/off.

dq = deque()


def writeln(s):
    tmp_stdout = sys.stdout
    sys.stdout = sys.__stdout__
    print(s)
    sys.stdout = tmp_stdout




class DyalogKernel(Kernel):

    implementation = 'Dyalog'
    implementation_version = __version__
    language = 'APL'
    language_version = '0.1'


    language_info = {
        'name': 'APL',
        'mimetype': 'text/apl',
        'file_extension': '.apl'
    }




    banner = "Dyalog APL kernel"
    connected = False


    # To save receive requests and prevent unneeded, lets put the max number here

    RIDE_PW = 32767


    dyalog_subprocess = None

    def out_error(self, s):
        _content = {
            'output_type': 'stream',
            'name': 'stderr',  # stdin or stderr
            'text': s
        }
        self.send_response(self.iopub_socket, 'stream', _content)

    def out_png(self, s):
        _content = {
            'output_type' : 'display_data',
            'data': {
                #'text/plain' : ['multiline text data'],
                'image/png':s,
                #'application/json':{
                   #JSON data is included as-is
                #  'json':'data',
                #},
            },
            'metadata' : {
                'image/svg':{
                    'width':120,
                    'height':80,
                },
            },
        }
        self.send_response(self.iopub_socket, 'display_data', _content)


    def out_html(self, s):
        _content = {
            # 'output_type': 'display_data',
            'data': {'text/html': s},
            'execution_count': self.execution_count,
            'metadata': ''
            # 'transient': ''
        }
        self.send_response(self.iopub_socket, 'execute_result', _content)


    def out_result(self, s):
        #injecting css: white-space:pre. Means no wrapping, RIDE SetPW will take care about line wrapping

        html_start = '<span style="white-space:pre; font-family: monospace">'
        html_end = '</span>'

        _content = {
            # 'output_type': 'display_data',
            # 'data': {'text/plain': s},
            'data': {'text/html': html_start + html.escape(s, False) + html_end},
            'execution_count': self.execution_count,
            'metadata': ''

            # 'transient': ''
        }

        self.send_response(self.iopub_socket, 'execute_result', _content)


    def out_stream(self, s):
        _content = {
            'output_type': 'stream',
            'name': 'stdin',  # stdin or stderr
            'text': s
        }
        self.send_response(self.iopub_socket, 'stream', _content)

    def dyalog_ride_connect(self):

        timeout = time.time() + RIDE_INIT_CONNECT_TIME_OUT




        while True:
            self.dyalogTCP = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            self.dyalogTCP.settimeout(TCP_TIMEOUT)
            time.sleep(0.5)  # solves an issue with connecting to 17.0 on Linux
            try:
                self.dyalogTCP.connect((DYALOG_HOST, self._port))
                break
            except socket.error as msg:
                #writeln(msg)
                self.dyalogTCP.close()
                if time.time()>timeout:
                    break


        #fcntl.fcntl(self.dyalogTCP, fcntl.F_SETFL, os.O_NONBLOCK)

        received = ['','']

        self.ride_receive_wait()

        if len(dq)>0:
            received = dq.pop()

        if received[0] == handShake1[8:].decode("utf-8"):
            # handshake1
            self.dyalogTCP.sendall(handShake1)
            writeln("SEND " + handShake1[8:].decode("utf-8"))
            # handshake2
            self.ride_receive()
            if len(dq) > 0:
                received = dq.pop()
            if received[0] == handShake2[8:].decode("utf-8"):
                # handshake2
                self.dyalogTCP.sendall(handShake2)
                writeln("SEND " + handShake2[8:].decode("utf-8"))

                d = ["Identify", {"identity": 1}]
                self.ride_send(d)

                d = ["Connect", {"remoteId": 2}]
                self.ride_send(d)

                d = ["GetWindowLayout", {}]
                self.ride_send(d)

                d = ["SetPW", {"pw": self.RIDE_PW}]
                self.ride_send(d)
                self.ride_receive_wait()
                dq.clear()
                self.connected = True


    def __init__(self, **kwargs):





        # path to connection_file. In case we need it in the close future
        #from ipykernel import get_connection_file
        #s = get_connection_file()
        #writeln("########## " + str(s))




        self._port = DYALOG_PORT
        # lets find first available port, starting from default DYALOG_PORT (:4502)
        # this makes sense only if Dyalog APL and Jupyter executables are on the same host (localhost)
        if DYALOG_HOST == '127.0.0.1':

            while True:
                sock = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
                result = sock.connect_ex((str(DYALOG_HOST).strip(),self._port))
                sock.close()
                #port is available
                if result !=0:
                    break
                else:
                    #try next port
                    self._port += 1




        # if Dyalog APL and Jupyter executables are on the same host (localhost) let's start instance of Dyalog
        if DYALOG_HOST == '127.0.0.1':
            if sys.platform.lower().startswith('win'):
                #Windows. Let's find an installed version to use
                hkcuReg = ConnectRegistry(None,HKEY_CURRENT_USER)
                dyalogKey = OpenKey(hkcuReg, r"SOFTWARE\Dyalog")
                installCount = QueryInfoKey(dyalogKey)[0]
                for n in range(installCount):
                    currInstall = EnumKey(dyalogKey, installCount - (n + 1))
                    if currInstall[:12] == "Dyalog APL/W":
                        break
                lastKey = OpenKey(hkcuReg, r"SOFTWARE\\Dyalog\\" + currInstall)
                dyalogPath = QueryValueEx(lastKey,"dyalog")[0] + "\\dyalog.exe"
                CloseKey(dyalogKey)
                CloseKey(lastKey)
                self.dyalog_subprocess = subprocess.Popen([dyalogPath,"RIDE_SPAWNED=1",'RIDE_INIT=SERVE::' + str(self._port).strip(), 'LOG_FILE=nul',  os.path.dirname(os.path.abspath(__file__)) + '/init.dws'])
            else:
                #linux, darwin... etc
                dyalog_env = os.environ.copy()
                dyalog_env['RIDE_INIT'] = 'SERVE::' + str(self._port).strip()
                dyalog_env['RIDE_SPAWNED'] = '1'
                dyalog_env['ENABLE_CEF'] = '0'
                dyalog_env['LOG_FILE'] = '/dev/null'
                if sys.platform.lower() == "darwin":
                    for d in sorted(os.listdir('/Applications')):
                        if re.match('^Dyalog-\d+\.\d+\.app$',d):
                            dyalog = '/Applications/'+d+'/Contents/Resources/Dyalog/mapl'
                else:
                    for v in sorted(os.listdir('/opt/mdyalog')):
                        if re.match('^\d+\.\d+$',v):
                            dyalog = '/opt/mdyalog/'+v+'/'
                            dyalog += sorted(os.listdir(dyalog))[-1]+'/'
                            dyalog += sorted(os.listdir(dyalog))[-1]+'/'+'mapl'
                self.dyalog_subprocess = subprocess.Popen([dyalog, '+s', '-q', os.path.dirname(os.path.abspath(__file__)) + '/init.dws'], stdin=subprocess.PIPE, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, env=dyalog_env)




        #disable auto closing of brackets/quotation marks. Not very useful in APL
        #Pass None instead of False to restore auto-closing feature
        c = ConfigManager()
        c.update('notebook', {'CodeCell': {'cm_config': {'autoCloseBrackets': False}}})

        Kernel.__init__(self, **kwargs)

        self.dyalog_ride_connect()

    def recv_all(self, msg_len):
        msg = b''
        while msg_len:
            part = self.dyalogTCP.recv(msg_len)
            msg += part
            msg_len -= len(part)
        return msg

    # return False if no RIDE message has been received
    def ride_receive(self):
        data = b''
        rcv = False;
        while True:
            try:
                head = self.recv_all(8)
                a,b,c,d = head[:4]
                msg_len = a*0x1000000 + b*0x10000 + c*0x100 + d - 8
                if head[4:8] == b'RIDE':
                    rideMessage = self.recv_all(msg_len)
                    try:
                        rideMessage = rideMessage.decode("utf-8")
                    except:
                        writeln("JSON parse error")
                        return False
                    rideMessage = rideMessage.replace('\n', '\\n')
                    rideMessage = rideMessage.replace('\r', '\\r')
                    rcv = True
                    try:
                        json_data = json.loads(rideMessage)
                    except:
                        #what's been received is not RIDEs standard JSON, it has to be one of the 2 first string type handshake messages
                        json_data = []
                        json_data.append(rideMessage)
                        json_data.append("String")
                    writeln("RECV " + rideMessage)
                    dq.appendleft(json_data)
                else:
                    writeln("Invalid Ride message")
                    return False
            except socket.timeout:
                writeln('no data')
                break
        return rcv

    def ride_receive_wait(self):    # Like ride_receive but will keep trying until it gets data
        while True:
            if self.ride_receive(): break

    # d is python  list, json.
    def ride_send(self, d):
        json_str = 'XXXXRIDE' + json.dumps(d,separators=(',',':'))

        # json, fix all \r and \n. They should be escaped appropriately for JSON
        json_str = json_str.replace('\n', '\\n')
        json_str = json_str.replace('\r', '\\r')

        _data = bytearray(str.encode(json_str))


        l = len(_data)

        _data[0] = (l >> 24) & 0xff
        _data[1] = (l >> 16) & 0xff
        _data[2] = (l >> 8) & 0xff
        _data[3] = l & 0xff
        
        self.dyalogTCP.sendall(_data)
        writeln("SEND " + _data[8:].decode("utf-8"))

    def do_execute(self, code, silent, store_history=True, user_expressions=None,
                   allow_stdin=True):
        global SUSPEND
        code = code.strip()

        if not silent:
            if self.connected:
                lines = code.split('\n')
                match = re.search('^%suspend\s+(\w+)$', lines[0].lower(), re.IGNORECASE)
                if match:
                    suspend = match.group(1)
                    if suspend == 'on':
                        SUSPEND = True
                    elif suspend == 'off':
                        SUSPEND = False
                        self.ride_send(["GetSIStack", {}])
                        self.ride_receive_wait()
                        stack = dq.pop()[1].get('stack')
                        if stack:
                            self.execute_line("→\n"*len(stack))
                            self.ride_receive_wait()
                        dq.clear()
                    else:
                        self.out_error('JUPYTER NOTEBOOK: UNDEFINED ARGUMENT TO %suspend, USE EITHER on OR off')
                    lines = lines[1:]
                elif re.match('^\\s*∇', lines[0]):
                    if not re.match('\\s*∇$', lines[-1]):
                        self.out_error('DEFN ERROR: Missing closing ∇')
                    else:
                        lines[0]  = re.sub('^\\s*∇','',lines[0])
                        lines = lines[:-1]
                        self.define_function(lines)
                    lines=[]
                elif lines[0].lower() == ']dinput':
                    self.define_function(lines[1:])
                    lines = []
                try:
                    # the windows interpreter can only handle ~125 chacaters at a time, so we do one line at a time
                    for line in lines:
                        line = line + '\n'
                        self.execute_line(line)

                        dq.clear()
                        PROMPT_AVAILABLE = False
                        err = False
                        data_collection =''

                        # as long as we have queue dq or RIDE PROMPT is not available... do loop
                        while (len(dq)>0 or not PROMPT_AVAILABLE):

                            received = ['','']
                            if len(dq)==0:
                                self.ride_receive_wait()

                            received = dq.pop()

                            if received[0]=='AppendSessionOutput':
                                if not PROMPT_AVAILABLE:
                                    data_collection = data_collection + received[1].get('result')
                            elif received[0]=='SetPromptType':
                                pt = received[1].get('type')
                                if pt == 0:
                                    PROMPT_AVAILABLE = False
                                elif pt == 1:
                                    PROMPT_AVAILABLE = True
                                    if len(data_collection) > 0:
                                        if err:
                                            self.out_error(data_collection)
                                        else:
                                            self.out_result(data_collection)
                                        data_collection = ''
                                    err = False
                                elif pt == 2:
                                    self.execute_line("→\n")
                                    raise ValueError('JUPYTER NOTEBOOK: Input through ⎕ is not supported')
                                elif pt == 4:
                                    time.sleep(1)
                                    raise ValueError('JUPYTER NOTEBOOK: Input through ⍞ is not supported')

                            elif received[0]=='ShowHTML':
                                self.out_html(received[1].get('html'))
                            elif received[0]=='HadError':
                                # in case of error, set the flag err
                                # it should be reset back to False only when prompt is available again.
                                err = True
                            #actually we don't want echo
                            elif received[0]=='OpenWindow':
                                if not SUSPEND:
                                    self.execute_line("→\n")
                            elif received[0]=='EchoInput':
                                pass
                            elif received[0]=='OptionsDialog':
                                self.ride_send(["ReplyOptionsDialog", {"index": -1, "token": received[1].get('token')}])
                            #self.pa(received[1].get('input'))
                except KeyboardInterrupt:
                    self.ride_send(["StrongInterrupt", {}])
                    if not SUSPEND:
                        self.execute_line("→\n")
                    self.out_error('INTERRUPT')
                    self.ride_receive_wait()
                    dq.clear()
                except ValueError as err:
                    self.out_error(str(err))
                    self.ride_receive_wait()
                    dq.clear()

            else:
                self.out_error('Dyalog APL not connected')

        reply_content = {'status': 'ok',
                # The base class increments the execution count
                'execution_count': self.execution_count,
                'payload': [],
                'user_expressions': {},
                }

        return reply_content

    def execute_line(self, line):
        self.ride_send(["Execute", {"trace": 0, "text": line}])

    def define_function(self, lines):
        self.execute_line("⎕SE.Dyalog.ipyFn←''\n")
        for line in lines:
            quoted = "'"+line.replace("'","''")+"'"
            self.execute_line("⎕SE.Dyalog.ipyFn,←⊂,"+quoted+"\n")
            self.ride_receive_wait()
        dq.clear()
        self.execute_line("{''≢0⍴r←⎕FX ⍵:511 ⎕SIGNAL⍨'DEFN ERROR: Issue on line ',⍕r}⎕SE.Dyalog.ipyFn\n")
        self.execute_line("⎕EX'⎕SE.Dyalog.ipyFn'\n")
        self.ride_receive_wait()
        while len(dq)>0:
            msg = dq.pop()
            if msg==["HadError", {"error": 511,"dmx": 0}]:
                msg = dq.pop()
                if msg[0]=='AppendSessionOutput':
                    self.out_error(msg[1].get('result'))


    def do_shutdown(self, restart):
        #shutdown Dyalog executable only if Jupyter kernel has started it.

        if DYALOG_HOST == '127.0.0.1':
            if self.connected:
                self.ride_send(["Exit", {"code": 0}])
         #   time.sleep(2)
         #   if self.dyalog_subprocess:
         #       self.dyalog_subprocess.kill()

        self.dyalogTCP.close()
        self.connected = False
        return {'status': 'ok', 'restart': restart}

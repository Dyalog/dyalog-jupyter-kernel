import os
import subprocess
import sys

def install_kernel_spec():
    kernel_spec_path = os.path.join(os.path.dirname(__file__), 'dyalog_apl')
    subprocess.run([sys.executable, '-m', 'jupyter', 'kernelspec', 'install', kernel_spec_path, '--user'], check=True)

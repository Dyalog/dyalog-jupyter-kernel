 {_}Init hereDir;tmp ⍝ dummy left arg for old ⎕FIX
 tmp←⎕NS ⍬
 tmp.⎕CY'salt'
 {}tmp.enableSALT
 ⎕SE.UCMD'←box on -f=on -t=tree' ⍝ TryAPL's boxing settings
 ⎕PP←10                          ⍝ TryAPL's precision
 ⎕RTL←1 ⍝ wait one sec for ⍞ input...
 ⎕TRAP←1006,'C→' ⍝ then cut back
 ⎕EX'Init' ⍝ remove self
 {}⎕SE.SALT.Settings'cmddir ,',hereDir
 ⍝ Check once per minute whether kernel is connected, exit interpreter if not
 'Event'('Timer' '⍎{~⍵:⎕OFF}3501⌶⍬')⎕WS⍨'⎕SE.Jupyter.Connected'⎕WC'Timer' 60E3
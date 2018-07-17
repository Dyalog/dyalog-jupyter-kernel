 {_}Init hereDir;tmp ⍝ dummy left arg for old ⎕FIX
 tmp←⎕NS⍬
 tmp.⎕CY'salt'
 tmp.enableSALT
 ⎕SE.UCMD'box on -f=on -t=tree' ⍝ TryAPL's boxing settings
 ⎕PP←6                          ⍝ TryAPL's precision
 ⎕EX'Init' ⍝ remove self
 ⎕←'Dyalog APL Jupyter kernel initialised from ',hereDir,'init.dyalog'

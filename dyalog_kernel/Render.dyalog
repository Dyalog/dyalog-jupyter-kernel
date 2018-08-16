:Namespace Render ⍝ 1.00

    ⎕IO←1 ⋄ ⎕ML←1

    L←819⌶             ⍝ Lowercase
    ride←3501⌶⍬        ⍝ Controlled by RIDE protocol?
    RideRender←3500⌶ ⍝ Send HTML thorugh RIDE protocol

    ∇ r←List;types
      r←⎕NS¨⍬ ⍬
    ⍝ Name, group, short description and parsing rules
      r.Name←'HTML' 'Plot'
      r.Group←⊂'Output'
      r.Desc←'Render HTML/SVG' 'Plot data',¨⊂'in appropriate window'
      r.Parse←'' '1L -type='
    ∇

    ∇ r←Run(cmd input);Causeway;SharpPlot;System;html;typeIdx;typeName;typeNames;⎕USING;value;left
      r←⍬⊤⍬
      :Select cmd
      :Case 'HTML'
          Show&##.THIS⍎input
      :Case 'Plot'
          value←##.THIS⍎⊃input.Arguments
          ⎕USING←',system.dll' ',system.drawing.dll' ',sharpplot.dll'
          :If 0=⎕NC'Causeway'
              (System.Drawing←System←Causeway←⎕NS ⍬).⎕CY'sharpplot.dws'
          :EndIf
          SharpPlot←⎕NEW Causeway.SharpPlot
     
          typeNames←'D'SharpPlot.⎕NL ¯3
          typeIdx←⊃⍸(∨/(L'LineGraph'input.Switch'type')⍷L)¨typeNames
          :If ×typeIdx
              typeName←typeIdx⊃typeNames
              (SharpPlot⍎typeName)value
              html←SharpPlot.RenderSvg Causeway.SvgMode.FixedAspect
          :Else
              r←'** Invalid type: ',input.type
          :EndIf
          html Show&⍨⊃input.Arguments
      :EndSelect
    ∇

    ∇ r←level Help cmd
      :Select cmd
      :Case 'Render'
          r←'Help text to appear for ]OUTPUT.Render -??'
      :EndSelect
    ∇

    _←{⍺⍵}
      Show←{
          9∊⎕NC'⍵':(⍕∇ Render)⍵
          ⍺←⊃'3500⌶'_⍨'<title>(.*)</title>'⎕S'\1'
          ride:{}(⍺ RideRender⊢)⍵
          Format←Encode(⍺ Document 96∘Shrink)⍣(2∊⎕NC'⍺')
          (#.⎕NEW'HTMLRenderer'_,⊂'HTML'_ Format ⍵).Wait
      }
    Encode←⎕UCS'UTF-8'∘⎕UCS
    Document←{'<html><head><title>',(Entity∊⍺),'</title></head><body>',⍵,'</body></html>'}
    Entity←'<' '\&'⎕R'\&gt;' '\&amp;'
    Char←{⎕UCS⍎(m←L⍵.Match)(⊢(⍕16⊥¯1+1↓⍳)⍣('x'∊m)∩)⌊⎕D,⎕A}
    Unentity←'&#[\da-fx]+;'⎕R Char⍠1('&amp;' '&lt;' '&gt;'⎕R'\&' '<' '>'⍠1)
    Shrink←{' height="100%"'⎕R(' height="',(⍕⍺),'\%"')⊢⍵}

    ∇ html←Render ref
      :Trap 0
          ref←⎕NEW⍣(~9.1∊⎕NC'ref')⊢ref
          :If 3=⌊|ref.⎕NC⊂'Compose'
              ref.Compose
          :EndIf
          html←ref.Render
      :Else
          html←'[unable to render]'
      :EndTrap
    ∇

      Clean←{
          shape←⍴⍵
          reshape←shape~1
          0 reshape≡(≢shape)shape:⍵
          ~0∊⍴reshape:reshape⍴⍵
          1≥|≡⍵:,⍵
          ⊃⍵
      }

:EndNamespace

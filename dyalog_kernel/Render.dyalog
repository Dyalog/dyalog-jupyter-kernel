:Namespace Render ⍝ V1.00
⍝ 2018 08 16 Adam: Initial commit

    ⎕IO←1 ⋄ ⎕ML←1

    :SECTION IBEAMS
    L←819⌶           ⍝ Lowercase
    ride←3501⌶⍬      ⍝ Controlled by RIDE protocol?
    RideRender←3500⌶ ⍝ Send HTML thorugh RIDE protocol
    :ENDSECTION

    :SECTION UCMD
    ∇ r←List
      r←⎕NS¨⍬ ⍬
      r.Name←'HTML' 'Plot'
      r.Desc←'Render HTML or SVG' 'Plot data',¨⊂' using an appropriate method'
      r.(Group Parse)←⊂'Output' ''
    ∇

    ∇ r←Run(cmd input);Causeway;SharpPlot;System;typeIdx;typeName;typeNames;⎕USING;type;expr;data
      r←⍬⊤⍬
      :Select cmd
      :Case 'HTML'
          Show&##.THIS⍎input
      :Case 'Plot'
          ⎕USING←',system.dll' ',system.drawing.dll' ',sharpplot.dll'
          :If 0=⎕NC'Causeway'
              (System.Drawing←System←Causeway←⎕NS ⍬).⎕CY'sharpplot.dws'
          :EndIf
          SharpPlot←⎕NEW Causeway.SharpPlot
     
          typeNames←'D'SharpPlot.⎕NL ¯3
          type←'LineGraph'ParseType input
          typeIdx←typeNames Where type
          :If ×typeIdx
              expr←Expr input
              data←##.THIS⍎expr
              typeName←typeIdx⊃typeNames
              (SharpPlot⍎typeName)data
              expr Show&SharpPlot.RenderSvg Causeway.SvgMode.FixedAspect
          :Else
              r←'** Invalid type: ',type
          :EndIf
      :EndSelect
    ∇

    ∇ r←level Help cmd;n;s;type
      n←List.Name⍳⊂cmd
      :If 'Plot'≡cmd
          type←ParseType ##.##.arg
      :AndIf 0≢type
          n←Chart.GetTypes Where type
          :If ×n
              type←n⊃Chart.GetTypes
              (syntax description)←DescribeData type
              r←⊂']',cmd,syntax,' -type=',type
              r,←,/': ' '. ' '.',¨⍨n⊃Chart.(CHARTS[;DESC])
              :If ×level
                  r,←description
              :Else
                  r,←⊂']',cmd,' -type=',type,' -??   ⍝ for argument details'
              :EndIf
          :Else
              r←,⊂'* Invalid chart type: ',type
              r,←⊂'Valid chart type names are:'
              r,←,/' ',¨Chart.GetTypes
          :EndIf
      :Else
          r←⊂']',cmd,n⊃' {code}' ' data [-type={name}]'
          r,←n⌷List.Desc
          :If ×level
              r,←⊂''
              :Select cmd
              :Case 'HTML'
                  r,←⊂'code  an expression returning HTML or SVG code'
              :Case 'Plot'
                  r,←⊂'data  a simple vector or a vector of vectors (one per coordinate or series)'
                  r,←⊂'name  the type name of chart to be produced (default: Line), one of:'
                  :If 1=level
                      r,←⊂'     ',∊' ',¨Chart.GetTypes
                      r,←⊂''
                      r,←⊂']',cmd,' -???              ⍝ for summary description of chart types'
                      r,←⊂']',cmd,' -type={name} -?   ⍝ for detailed description of chart type {name}'
                  :Else
                      r,←↓⍕'  '_ ListTypes
                  :EndIf
              :EndSelect
              s←'Rendering will happen by sending through the RIDE protocol if APL is being controlled through that ('
              s,←'not' 'as is'⊃⍨1+ride
              s,←' the case right now), otherwise a stand-alone HTMLRenderer will be used.'
              r,←''s
          :Else
              r,←⊂']',cmd,' -??   ⍝ for details'
          :EndIf
      :EndIf
    ∇
    :ENDSECTION

    :SECTION UTILS

    ∇ chart←Chart
      :If ×⎕NC'CHART'
          chart←CHART
      :Else
          chart←CHART←(⎕SE.SALT.Load'[SALT]/spice/chartwizard.dyalog -noname').Chart
      :EndIf
    ∇

    ∇ types←ListTypes
      types←Chart.(GetTypes,⍪'^\w+'⎕R''⊢2⊃¨1↓CHARTS[;DESC])
    ∇

    ∇ (syntax description)←DescribeData type;n;types;names
      (types names)←Chart.GetSeries type
      types←Chart.GetFormatDescription¨types
      syntax←∊' ',¨names
      description←↓⍕' ',names,⍪types
    ∇

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

      ParseType←{
          ⍺←⊢
          ⍺ If(0∘≡)((⎕NEW ⎕SE.Parser'-type=').Parse⍕'-\w+=\w+'⎕S'&'⊢'''[^'']'''⎕R''⊢⍵).type
      }
      Show←{
          9∊⎕NC'⍵':(⍕∇ Render)⍵
          ⍺←⊃'3500⌶'_⍨'<title>(.*)</title>'⎕S'\1'
          ride:{}(⍺ RideRender⊢)⍵
          Format←Encode(⍺ Document 96∘Shrink)⍣(2∊⎕NC'⍺')
          (#.⎕NEW'HTMLRenderer'_,⊂'HTML'_ Format ⍵).Wait
      }
      If←{
          ⍺←⊢
          ⍺(⍺⍺⊣⊢)⍣(⍺ ⍵⍵ ⍵)⊢⍵
      }

    Char←{⎕UCS⍎⍵.Match(⊢(⍕16⊥¯1+1↓⍳)If('x'∊⊣)∩)ÖL⎕D,⎕A}
    Document←{'<html><head><title>',(Entity∊⍺),'</title></head><body>',⍵,'</body></html>'}
    Shrink←{' height="100%"'⎕R(' height="',(⍕⍺),'\%"')⊢⍵}

    _←{⍺⍵}           ⍝ Juxtapose
    ÖL←{(L⍺)⍺⍺(L⍵)}  ⍝ Over Lowercase

    Where←⊃∘⍸(∨/⍷⍨ÖL)¨∘⊂
    Encode←⎕UCS'UTF-8'∘⎕UCS

    Expr←'^ +| +$'⎕R''∘⊢'''[^'']''' '-\w+=\w+'⎕R'&' ''
    Entity←'<' '\&'⎕R'\&gt;' '\&amp;'
    Unentity←'&#[\da-fx]+;'⎕R Char⍠1∘⊢'&amp;' '&lt;' '&gt;'⎕R'\&' '<' '>'⍠1
    :ENDSECTION
:EndNamespace

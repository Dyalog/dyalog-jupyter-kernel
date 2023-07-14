# Writing notebook content

**Note:** These are about writing notebooks on a [locally installed](./install.md) Jupyter system.

## Editing and creating cells

Click on any code cell to begin editing it, then press *Ctrl*+*Enter* to execute the code.

Use the `➕︎` button to insert a new code cell. You can switch a cell contain explanations, comments, etc. by selecting *Markdown* from the drop-down saying *Code∨*. Additional commands can be found by clicking the `⌨︎` button.

## Defining functions

Single-line dfns and tacit functions may be defined among other code in a code cell:

```APL
AddNext←{⍵,+/¯2↑⍵}
Fibonacci←AddNext/⌽∘⍳
Fibonacci 10
```

***Note:** Tradfns; multi-line dfns; and scripted :Namespaces, :Classes and :Interfaces must be defined in a single code cell.*

Tradfns may be defined in a code cell by beginning the first line with a `∇` and having a sole `∇` after the last line:

```APL
∇Greet name
 ⎕←'Hello, ',name
∇
```

To define a multi-line dfn, begin a code cell with the line `]dinput`. For example:

```APL
]dinput
root←{
    ⍺←2
    ⍵*÷⍺
}
```

To define a scripted :Namespace, :Class or :Interface, begin and end the code cell with the corresponding :Keyword and :EndKeyword. For example;
```APL
:Namespace myns
  ∇Greet name
   ⎕←'Hello, ',name
  ∇
:EndNamespace
```

## Rich content

You can indicate that the result of a statement should be rendered as HTML by using the `]html` user command:

```APL
p←'<p>Please:</p>'
b←'<button onclick="alert(''Thank you!'')">Click</button>'
]html p,b
```

You can plot data with with the `]plot` user command:
```APL
x←(⍳100)÷20
y←(⊢*÷)x
]plot y x
```

Choose chart type with the `-type=` modifier:

```APL
]plot 3 1 4 1 6 -type=pie
```

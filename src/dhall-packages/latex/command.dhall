let LaTeX = ./Type.dhall

let Args = { name : Text, arguments : List Text, newline : Bool }

let command
    : Args → LaTeX
    = λ(cmd : Args) →
      λ(_LaTeX : Type) →
      λ(latex : ./elements.dhall _LaTeX) →
        latex.command cmd

in  command

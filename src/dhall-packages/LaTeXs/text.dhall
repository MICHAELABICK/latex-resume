let LaTeX = ./Type.dhall

let text
    : Text → LaTeX
    = λ(t : Text) →
      λ(_LaTeX : Type) →
      λ(latex : ./elements.dhall _LaTeX) →
        latex.text t

in  text

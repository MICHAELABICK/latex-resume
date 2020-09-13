let Prelude = ./Prelude.dhall

let List/map = Prelude.List.map

let LaTeX = ./Type.dhall

let document
    : List LaTeX → LaTeX
    = λ(d : List LaTeX) →
      λ(_LaTeX : Type) →
      λ(latex : ./elements.dhall _LaTeX) →
        latex.document (List/map LaTeX _LaTeX (λ(x : LaTeX) → x _LaTeX latex) d)

in  document

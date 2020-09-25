let Prelude = ./Prelude.dhall

let List/map = Prelude.List.map

let LaTeX = ./Type.dhall

let Args = { name : Text, arguments : List Text, content : List LaTeX }

let environment
    : Args → LaTeX
    = λ(env : Args) →
      λ(_LaTeX : Type) →
      λ(latex : ./elements.dhall _LaTeX) →
        latex.environment
          (   env
            ⫽ { content =
                  List/map
                    LaTeX
                    _LaTeX
                    (λ(x : LaTeX) → x _LaTeX latex)
                    env.content
              }
          )

in  environment

let Prelude = ./Prelude.dhall

let List/map = Prelude.List.map

let LaTeX = ./Type.dhall

let Args = { name : Text, content : List LaTeX }

let environment
    : Args → LaTeX
    = λ(env : Args) →
      λ(_LaTeX : Type) →
      λ ( latex
        : { text : Text → _LaTeX
          , command : { name : Text, arguments : List Text } → _LaTeX
          , environment : { name : Text, content : List _LaTeX } → _LaTeX
          }
        ) →
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

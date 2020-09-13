let LaTeX/Type
    : Type
    = ∀(LaTeX : Type) →
      ∀ ( latex
        : { text : Text → LaTeX
          , command : { name : Text, arguments : List Text } → LaTeX
          , environment : { name : Text, content : List LaTeX } → LaTeX
          }
        ) →
        LaTeX

in  LaTeX/Type

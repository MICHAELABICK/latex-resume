let elements =
      λ(LaTeX : Type) →
        { text : Text → LaTeX
        , command :
            { name : Text, arguments : List Text, newline : Bool } → LaTeX
        , environment :
            { name : Text, arguments : List Text, content : List LaTeX } → LaTeX
        }

in  elements

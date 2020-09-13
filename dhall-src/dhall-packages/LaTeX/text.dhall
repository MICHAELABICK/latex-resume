let LaTeX = ./Type.dhall


let text : Text -> LaTeX =
    \(t : Text)
 -> \(_LaTeX : Type)
 -> \(latex : {
      , text : Text -> _LaTeX
      , command : {
          , name : Text
          , arguments : List Text
          } -> _LaTeX
      , environment : {
          , name : Text
          , content : List _LaTeX
          } -> _LaTeX
      }
    )
 -> latex.text t

in text

let LaTeX = ./Type.dhall


let Args = {
      , name : Text
      , arguments : List Text
      }

let command : Args -> LaTeX =
    \(cmd : Args)
 -> \(LaTeX : Type)
 -> \(latex : {
      , text : Text -> LaTeX
      , command : {
          , name : Text
          , arguments : List Text
          } -> LaTeX
      , environment : {
          , name : Text
          , content : List LaTeX
          } -> LaTeX
      }
    )
 -> latex.command cmd

in command

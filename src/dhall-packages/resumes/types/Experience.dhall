let Position = ./Position.dhall

let Experience =
      { Type =
          { corporation : Text
          , position : Position
          , dates : { from : Text, to : Text }
          , bullets : List Text
          }
      , default.position = Position.None
      }

in  Experience

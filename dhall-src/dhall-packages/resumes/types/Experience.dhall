let Experience =
      { Type =
          { corporation : Text
          , position : Optional Text
          , dates : { from : Text, to : Text }
          , bullets : List Text
          }
      , default.position = None Text
      }

in  Experience

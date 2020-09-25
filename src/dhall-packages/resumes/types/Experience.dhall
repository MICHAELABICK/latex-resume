let dates = ../../dates/package.dhall

let Position = ./Position.dhall

let Experience =
      { Type =
          { corporation : Text
          , position : Position
          , dates : dates.DateRange
          , bullets : List Text
          }
      , default.position = Position.None
      }

in  Experience

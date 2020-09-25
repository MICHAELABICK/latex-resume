let dates = ../../dates/package.dhall

let Project =
      { Type =
          { name : Text
          , dates : { from : dates.Date, to : dates.EndDate }
          , summary : Text
          , bullets : List Text
          }
      , default.bullets = [] : List Text
      }

in  Project

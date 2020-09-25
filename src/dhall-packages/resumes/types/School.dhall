let dates = ../../dates/package.dhall

in  { name : Text
    , location : Text
    , dates : { to : dates.Date, from : dates.Date }
    , major : Text
    , minor : Optional Text
    , gpa : Double
    , graduated : Bool
    , awards : Text
    }

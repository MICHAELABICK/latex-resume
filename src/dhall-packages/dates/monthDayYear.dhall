let types = ./types.dhall

let Date = types.Date

let Day = types.Day

let Month = types.Month

let Year = types.Year

let monthDayYear
    : Month → Day → Year → Date
    = λ(month : Month) → λ(day : Day) → λ(year : Year) → { day, month, year }

in  monthDayYear

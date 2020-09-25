let types = ./types.dhall

let Date = types.Date

let Day = types.Day

let Month = types.Month

let Year = types.Year

let monthDayYear : Month -> Day -> Year -> Date =
      \(month : Month) ->
      \(day : Day) ->
      \(year : Year) ->
        { day = day, month = month, year = year }

in monthDayYear

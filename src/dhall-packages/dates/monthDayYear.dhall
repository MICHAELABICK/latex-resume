-- FIXME: Dhall now has a Date type,
-- because there is actually overlap in the namespaces
-- this is preventing us from using a new Dhall version.
-- Therefor, we need to backport this as a patched or minor semver
let types = ./types.dhall

let Date = types.Date

let Day = types.Day

let Month = types.Month

let Year = types.Year

let monthDayYear
    : Month → Day → Year → Date
    = λ(month : Month) → λ(day : Day) → λ(year : Year) → { day, month, year }

in  monthDayYear

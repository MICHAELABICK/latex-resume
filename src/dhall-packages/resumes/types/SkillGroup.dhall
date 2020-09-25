let Tagged = ./Tagged/package.dhall

let SkillGroup =
      \(Tags : Type) ->
        { name : Text
        , skills : List (Tagged.Type Tags Text)
        }

in SkillGroup

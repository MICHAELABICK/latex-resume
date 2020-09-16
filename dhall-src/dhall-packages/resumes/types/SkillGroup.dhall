let TagSet = ./TagSet/package.dhall

let SkillGroup =
      \(Tags : Type) ->
        { name : Text
        , skills : List (TagSet.Tagged Tags Text)
        }

in SkillGroup

let SkillSectionData =
      \(Tags : Type) ->
        {
        , groups : List (./SkillGroup.dhall Tags)
        , longest_group_title : Text
        }

in SkillSectionData
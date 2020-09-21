let Tagged = ./types/Tagged/package.dhall

let types =
      λ(Tags : Type) →
        { Section = ./types/Section.dhall Tags
        , SectionData = ./types/SectionData.dhall Tags
        , School = ./types/School.dhall
        , Experience = ./types/Experience.dhall
        , SkillSectionData = ./types/SkillSectionData.dhall Tags
        , SkillGroup = ./types/SkillGroup.dhall Tags
        , Award = ./types/Award.dhall
        , PlacedAward = ./types/PlacedAward.dhall
        , TimePeriodAward = ./types/TimePeriodAward.dhall
        , Position = ./types/Position.dhall
        , ProgressionPosition = ./types/ProgressionPosition.dhall
        , Tagged =
            {
            , Type = Tagged.Type Tags
            , tagText = Tagged.tagText Tags
            }
        }

in  types

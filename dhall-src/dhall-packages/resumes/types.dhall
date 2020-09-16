let TagSet = ./types/TagSet/package.dhall

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
        , TagSet =
            { Type = TagSet.Type Tags
            , build = TagSet.build Tags
            , Tagged = TagSet.Tagged Tags
            , tagText = TagSet.tagText Tags
            , default = TagSet.default Tags
            }
        }

in  types

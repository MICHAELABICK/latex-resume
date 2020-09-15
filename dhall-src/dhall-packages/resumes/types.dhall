let types =
      λ(Tags : Type) →
        let TagSet =
              { Type = ./types/TagSet/Type.dhall Tags
              , build = ./types/TagSet/build.dhall Tags
              }

        in  { Section = ./types/Section.dhall Tags
            , SectionData = ./types/SectionData.dhall Tags
            , School = ./types/School.dhall
            , Experience = ./types/Experience.dhall Tags
            , SkillSectionData = ./types/SkillSectionData.dhall
            , SkillGroup = ./types/SkillGroup.dhall
            , Award = ./types/Award.dhall
            , PlacedAward = ./types/PlacedAward.dhall
            , TimePeriodAward = ./types/TimePeriodAward.dhall
            , TagSet
            }

in  types

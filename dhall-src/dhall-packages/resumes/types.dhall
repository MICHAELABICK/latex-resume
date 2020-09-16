let types =
      λ(Tags : Type) →
        let TagSet = ./types/TagSet/package.dhall

        let Tagged = ./types/Tagged/package.dhall

        in  { Section = ./types/Section.dhall Tags
            , SectionData = ./types/SectionData.dhall Tags
            , School = ./types/School.dhall
            , Experience = ./types/Experience.dhall
            , SkillSectionData = ./types/SkillSectionData.dhall
            , SkillGroup = ./types/SkillGroup.dhall
            , Award = ./types/Award.dhall
            , PlacedAward = ./types/PlacedAward.dhall
            , TimePeriodAward = ./types/TimePeriodAward.dhall
            , TagSet = { Type = TagSet.Type Tags, build = TagSet.build Tags }
            , Tagged =
              { Type = Tagged.Type Tags, default = Tagged.default Tags }
            }

in  types

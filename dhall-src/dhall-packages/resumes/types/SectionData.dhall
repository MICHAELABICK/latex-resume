let TagSet = ./TagSet/package.dhall

let Experience = ./Experience.dhall

let SectionData =
      λ(Tags : Type) →
        < Education : ./School.dhall
        | Experiences : List (TagSet.Tagged Tags Experience.Type)
        | Skills : ./SkillSectionData.dhall Tags
        | Awards : List ./Award.dhall
        >

in  SectionData

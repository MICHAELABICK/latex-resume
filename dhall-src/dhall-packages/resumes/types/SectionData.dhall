let Tagged = ./Tagged/Type.dhall

let Experience = ./Experience.dhall

let SectionData =
      λ(Tags : Type) →
        < Education : ./School.dhall
        | Experiences : List (Tagged Tags Experience.Type)
        | Skills : ./SkillSectionData.dhall
        | Awards : List ./Award.dhall
        >

in  SectionData

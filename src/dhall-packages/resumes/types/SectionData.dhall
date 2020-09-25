let Tagged = ./Tagged/package.dhall

let Experience = ./Experience.dhall

let SectionData =
      λ(Tags : Type) →
        < Education : ./School.dhall
        | Experiences : List (Tagged.Type Tags Experience.Type)
        | Skills : ./SkillSectionData.dhall Tags
        | Awards : List (Tagged.Type Tags ./Award.dhall)
        >

in  SectionData

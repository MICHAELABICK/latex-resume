let Experience = ./Experience.dhall

let SectionData =
      λ(Tags : Type) →
        < Education : ./School.dhall
        | Experiences : List (Experience Tags).Type
        | Skills : ./SkillSectionData.dhall
        | Awards : List ./Award.dhall
        >

in  SectionData

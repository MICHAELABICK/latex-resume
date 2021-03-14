let SectionItem =
      < School : ./School.dhall
      | Experience : (./Experience.dhall).Type
      | Projects : List (./Project.dhall).Type
      | Skills : ./SkillSectionData.dhall
      | Awards : List ./Award.dhall
      >

in  SectionItem

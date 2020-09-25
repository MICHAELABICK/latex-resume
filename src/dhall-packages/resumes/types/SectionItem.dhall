let Tagged = (./Tagged/package.dhall).Type

let SectionItem =
      λ(Tags : Type) →
        <
        | School : ./School.dhall
        | Experience : Tagged Tags (./Experience.dhall).Type
        | Projects : List (./Project.dhall).Type
        | Skills : ./SkillSectionData.dhall Tags
        | Awards : List (Tagged Tags ./Award.dhall)
        >

in  SectionItem

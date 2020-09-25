let SectionData =
      λ(Tags : Type) →
        < Education : ./School.dhall | Items : List (./SectionItem.dhall Tags) >

in  SectionData

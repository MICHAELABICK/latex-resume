let Section =
      λ(Tags : Type) → { title : Text, data : List (./SectionItem.dhall Tags) }

in  Section

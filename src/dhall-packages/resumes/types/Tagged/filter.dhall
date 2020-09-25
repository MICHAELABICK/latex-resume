let Prelude = ../../Prelude.dhall

let Tagged = ./Type.dhall

let filter
    : ∀(Tags : Type) →
      ∀(Item : Type) →
      ∀(matchTags : Tags → Bool) →
      ∀(items : List (Tagged Tags Item)) →
        List Item
    = λ(Tags : Type) →
      λ(Item : Type) →
      λ(matchTags : Tags → Bool) →
        let TaggedItem = Tagged Tags Item

        in  λ(items : List TaggedItem) →
              let filtered =
                    Prelude.List.filter
                      TaggedItem
                      (λ(x : TaggedItem) → matchTags x.tags)
                      items

              let unwrapped =
                    Prelude.List.map
                      TaggedItem
                      Item
                      (λ(x : TaggedItem) → x.item)
                      filtered

              in  unwrapped

in  filter

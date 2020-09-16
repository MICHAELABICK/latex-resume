let Tagged =
      \(Tags : Type) ->
      \(Item : Type) ->
        let TagSet = (../TagSet/package.dhall).Type Tags

        in  { item : Item
            , tags : TagSet
            }

in Tagged

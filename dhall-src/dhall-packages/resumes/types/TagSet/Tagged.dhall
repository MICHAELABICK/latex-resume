let TagSet = ./Type.dhall

let Tagged =
      \(Tags : Type) ->
      \(Item : Type) ->
        { item : Item
        , tags : TagSet Tags
        }

in Tagged

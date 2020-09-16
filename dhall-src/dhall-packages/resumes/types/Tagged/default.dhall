let Tagged = ./Type.dhall

let default =
      \(Tags : Type) ->
      \(matchTags : Tags -> Bool) ->
      \(Item : Type) ->
      \(default : Item) ->
      \(t : Tagged Tags Item) ->
        if t.tags matchTags then t.item else default

in default
      

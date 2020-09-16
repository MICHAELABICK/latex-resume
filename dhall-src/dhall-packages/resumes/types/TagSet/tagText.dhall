let build = ./build.dhall

let tagText =
      \(Tags : Type) ->
      \(tags : Tags) ->
      \(text : Text) ->
        { item = text
        , tags = build Tags tags
        }

in tagText

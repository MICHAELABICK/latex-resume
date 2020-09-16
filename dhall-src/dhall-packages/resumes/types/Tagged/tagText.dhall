let tagText =
      \(Tags : Type) ->
      \(tags : Tags) ->
      \(text : Text) ->
        { item = text
        , tags = tags
        }

in tagText

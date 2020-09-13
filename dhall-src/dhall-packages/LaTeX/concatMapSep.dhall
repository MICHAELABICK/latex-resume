let Prelude = ./Prelude.dhall

let LaTeX = ./Type.dhall

let newline = ./newline.dhall

let command = ./command.dhall

let text = ./text.dhall

let concatMapSep =
      \(seperator : List LaTeX) ->
      \(a : Type) ->
      \(func : a -> List LaTeX) ->
      \(xs : List a) ->
      let full_list =
            Prelude.List.concatMap
            a
            LaTeX
            (\(x : a) -> (func x) # seperator)
            xs

      let reversed = List/reverse LaTeX full_list
      let seperator_length = List/length LaTeX seperator
      let reversed_dropped = Prelude.List.drop seperator_length LaTeX reversed
      in List/reverse LaTeX reversed_dropped

let example0 = assert :
    concatMapSep
    [ newline ]
    Text
    (\(x : Text) -> [ command { name = "item", arguments = [] : List Text, newline = False }, text " ${x}" ])
    [ "item1", "item2", "item3" ]
    === [ command {name = "item", arguments = [] : List Text, newline = False }, text " item1", newline,
          command {name = "item", arguments = [] : List Text, newline = False }, text " item2", newline,
          command {name = "item", arguments = [] : List Text, newline = False }, text " item3"]

in concatMapSep

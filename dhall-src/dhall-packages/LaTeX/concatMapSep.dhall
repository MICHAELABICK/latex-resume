let Prelude = ./Prelude.dhall

let LaTeX = ./Type.dhall

let newline = ./newline.dhall

let command = ./command.dhall

let text = ./text.dhall

let concatMapSep =
      λ(seperator : List LaTeX) →
      λ(a : Type) →
      λ(func : a → List LaTeX) →
      λ(xs : List a) →
        let full_list =
              Prelude.List.concatMap a LaTeX (λ(x : a) → func x # seperator) xs

        let full_length = List/length LaTeX full_list

        let seperator_length = List/length LaTeX seperator

        let take_length = Prelude.Natural.subtract seperator_length full_length

        in  Prelude.List.take take_length LaTeX full_list

let example0 =
        assert
      :   concatMapSep
            [ newline ]
            Text
            ( λ(x : Text) →
                [ command
                    { name = "item"
                    , arguments = [] : List Text
                    , newline = False
                    }
                , text " ${x}"
                ]
            )
            [ "item1", "item2", "item3" ]
        ≡ [ command
              { name = "item", arguments = [] : List Text, newline = False }
          , text " item1"
          , newline
          , command
              { name = "item", arguments = [] : List Text, newline = False }
          , text " item2"
          , newline
          , command
              { name = "item", arguments = [] : List Text, newline = False }
          , text " item3"
          ]

in  concatMapSep

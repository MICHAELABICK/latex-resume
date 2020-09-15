let Experience =
      λ(Tags : Type) →
        { Type =
            { corporation : Text
            , position : Optional Text
            , dates : { from : Text, to : Text }
            , bullets : List Text
            , tags : ∀(matchTags : Tags → Bool) → Bool
            }
        , default.position = None Text
        }

in  Experience

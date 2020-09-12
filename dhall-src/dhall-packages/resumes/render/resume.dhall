let Prelude = ../Prelude.dhall
let XML = Prelude.XML

let types = ../types.dhall


let empty = XML.leaf { name = "empty", attributes = XML.emptyAttributes }

let toSection =
    \(section : types.Section)
 -> XML.element {
    , name = "section"
    , attributes = XML.emptyAttributes
    , content = [
        , XML.element {
            , name = "title"
            , attributes = XML.emptyAttributes
            , content = [ XML.text section.title ]
            }
        ]
    }


let toResume =
    \(sections : List types.Section)
 -> \(tags : List Text)
 -> XML.render
    ( XML.element {
      , name = "resume"
      , attributes = XML.emptyAttributes
      , content = [
          , XML.leaf { name = "section", attributes = XML.emptyAttributes }
          , XML.leaf { name = "section", attributes = XML.emptyAttributes }
          ]
      }
    )


 in toResume

let Prelude = ../Prelude.dhall

let List/concatMap = Prelude.List.concatMap

let LaTeX = ../../LaTeX/package.dhall

let types = ../types.dhall

let toSectionLaTeX =
      λ(section : types.Section) →
        [ LaTeX.command
            { name = "section", arguments = [ section.title ], newline = True }
        ]

let toResumeLaTeX =
      λ(sections : List types.Section) →
      λ(tags : List Text) →
        let document =
              List/concatMap types.Section LaTeX.Type toSectionLaTeX sections

        in  LaTeX.render
              ( LaTeX.document
                  [ LaTeX.command
                      { name = "documentclass"
                      , arguments = [] : List Text
                      , newline = True
                      }
                  , LaTeX.environment { name = "document", content = document }
                  ]
              )

in  toResumeLaTeX

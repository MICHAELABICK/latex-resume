let Prelude = ../Prelude.dhall

let Map = Prelude.Map.Type

let Entry = Prelude.Map.Entry

let Bool/fold = Prelude.Bool.fold

let List/concatMap = Prelude.List.concatMap

let Text/default = Prelude.Text.default

let LaTeX = ../../LaTeX/package.dhall

let types = ../types.dhall

let toKeyvalsArguments =
      λ(keyvals : Map Text Text) →
        let string =
              Prelude.Text.concatMapSep
                ","
                (Entry Text Text)
                (λ(x : Entry Text Text) → "${x.mapKey}={${x.mapValue}}")
                keyvals

        in  [ " ${string} " ]

let toSchoolLaTeX =
      λ(school : types.School) →
        let graduated = Bool/fold school.graduated Text "" school.dates.to

        let arguments =
              toKeyvalsArguments
                ( toMap
                    { name = school.name
                    , loc = school.location
                    , from = school.dates.from
                    , to = school.dates.to
                    , major = school.major
                    , minor = Text/default school.minor
                    , grad = graduated
                    , awards = school.awards
                    }
                )

        in  LaTeX.command { name = "school", arguments, newline = True }

let toExperienceLaTeX =
      λ(exp : types.Experience.Type) →
        let arguments =
              toKeyvalsArguments
                ( toMap
                    { corp = exp.corporation
                    , pos = exp.position
                    , from = exp.dates.from
                    , to = exp.dates.to
                    }
                )

        let bullets =
              LaTeX.concatMapSep
                [ LaTeX.newline ]
                Text
                ( λ(x : Text) →
                    [ LaTeX.command
                        { name = "item"
                        , arguments = [] : List Text
                        , newline = False
                        }
                    , LaTeX.text " ${x}"
                    ]
                )
                exp.bullets

        in  [ LaTeX.command { name = "experience", arguments, newline = True }
            , LaTeX.environment { name = "itemize", content = bullets }
            ]

let toSectionLaTeX =
      λ(section : types.Section) →
        let data =
              merge
                { Education =
                    λ(x : types.School) → [ toSchoolLaTeX x, LaTeX.newline ]
                , Experiences =
                    λ(x : List types.Experience.Type) →
                      Prelude.List.concatMap
                        types.Experience.Type
                        LaTeX.Type
                        toExperienceLaTeX
                        x
                }
                section.data

        in    [ LaTeX.command
                  { name = "section"
                  , arguments = [ section.title ]
                  , newline = True
                  }
              ]
            # data

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

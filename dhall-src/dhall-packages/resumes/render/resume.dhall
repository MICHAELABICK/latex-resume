let Prelude = ../Prelude.dhall

let Map = Prelude.Map.Type

let Entry = Prelude.Map.Entry

let Bool/fold = Prelude.Bool.fold

let List/concatMap = Prelude.List.concatMap

let Text/default = Prelude.Text.default

let LaTeX = ../../LaTeX/package.dhall

let toLaTeX =
      λ(Tags : Type) →
      λ(matchTags : Tags → Bool) →
        let types = ../types.dhall Tags

        let toKeyvalsArguments =
              λ(keyvals : Map Text Text) →
                let string =
                      Prelude.Text.concatMapSep
                        ","
                        (Entry Text Text)
                        (λ(x : Entry Text Text) → "${x.mapKey}={${x.mapValue}}")
                        keyvals

                in  [ " ${string} " ]

        let toItemize =
              λ(items : List Text) →
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
                  items

        let toSchoolLaTeX =
              λ(school : types.School) →
                let graduated =
                      Bool/fold school.graduated Text "" school.dates.to

                let arguments =
                      toKeyvalsArguments
                        ( toMap
                            { name = school.name
                            , gpa = "${Double/show school.gpa}/4.0"
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
                let position =
                      merge
                        { Progression =
                            λ(x : types.ProgressionPosition) →
                              "${x.first} to ${x.last}"
                        , Single = λ(x : Text) → x
                        , None = ""
                        }
                        exp.position

                let arguments =
                      toKeyvalsArguments
                        ( toMap
                            { corp = exp.corporation
                            , from = exp.dates.from
                            , to = exp.dates.to
                            , pos = position
                            }
                        )

                in  [ LaTeX.command
                        { name = "experience", arguments, newline = True }
                    , LaTeX.environment
                        { name = "itemize"
                        , arguments = [] : List Text
                        , content = toItemize exp.bullets
                        }
                    ]

        let toSkillGroupLaTeX =
              λ(sg : types.SkillGroup) →
                let skills =
                      Prelude.List.concatMap
                        (types.Tagged.Type Text)
                        Text
                        ( λ(x : types.Tagged.Type Text) →
                            if    matchTags x.tags
                            then  [ x.item ]
                            else  [] : List Text
                        )
                        sg.skills

                in  [ LaTeX.environment
                        { name = "groupitem"
                        , arguments = [ sg.name ]
                        , content = toItemize skills
                        }
                    ]

        let toAwardLaTeX =
              λ(awd : types.Award) →
                let keyvals =
                      merge
                        { Placed =
                            λ(x : types.PlacedAward) →
                              { name = x.name, col1 = x.date, col2 = x.place }
                        , TimePeriod =
                            λ(x : types.TimePeriodAward) →
                              { name = x.name, col1 = x.from, col2 = x.to }
                        }
                        awd

                let arguments = toKeyvalsArguments (toMap keyvals)

                in  [ LaTeX.command
                        { name = "award", arguments, newline = False }
                    ]

        let toSectionLaTeX =
              λ(section : types.Section) →
                let toExperiences =
                      λ(x : List (types.Tagged.Type types.Experience.Type)) →
                        Prelude.List.concatMap
                          (types.Tagged.Type types.Experience.Type)
                          LaTeX.Type
                          ( λ(te : types.Tagged.Type types.Experience.Type) →
                              if    matchTags te.tags
                              then  toExperienceLaTeX te.item
                              else  [] : List LaTeX.Type
                          )
                          x

                let toSkills =
                      λ(x : types.SkillSectionData) →
                        [ LaTeX.environment
                            { name = "skills"
                            , arguments = [ x.longest_group_title ]
                            , content =
                                Prelude.List.concatMap
                                  types.SkillGroup
                                  LaTeX.Type
                                  toSkillGroupLaTeX
                                  x.groups
                            }
                        ]

                let toAwards =
                      λ(x : List (types.Tagged.Type types.Award)) →
                        let filtered =
                              Prelude.List.concatMap
                                (types.Tagged.Type types.Award)
                                types.Award
                                ( λ(ta : types.Tagged.Type types.Award) →
                                    if    matchTags ta.tags
                                    then  [ ta.item ]
                                    else  [] : List types.Award
                                )
                                x

                        in  [ LaTeX.environment
                                { name = "awards"
                                , arguments = [] : List Text
                                , content =
                                    LaTeX.concatMapSep
                                      [ LaTeX.newline ]
                                      types.Award
                                      toAwardLaTeX
                                      filtered
                                }
                            ]

                let data =
                      merge
                        { Education =
                            λ(x : types.School) →
                              [ toSchoolLaTeX x, LaTeX.newline ]
                        , Experiences = toExperiences
                        , Skills = toSkills
                        , Awards = toAwards
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
                let document =
                      List/concatMap
                        types.Section
                        LaTeX.Type
                        toSectionLaTeX
                        sections

                in  LaTeX.render
                      [ LaTeX.command
                          { name = "documentclass"
                          , arguments = [ "resume" ]
                          , newline = True
                          }
                      , LaTeX.environment
                          { name = "document"
                          , arguments = [] : List Text
                          , content = document
                          }
                      ]

        in  toResumeLaTeX

in  toLaTeX

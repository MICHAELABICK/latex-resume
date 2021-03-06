let Prelude = ../Prelude.dhall

let dates = ../../dates/package.dhall

let Map = Prelude.Map.Type

let Entry = Prelude.Map.Entry

let Bool/fold = Prelude.Bool.fold

let List/concatMap = Prelude.List.concatMap

let Text/default = Prelude.Text.default

let LaTeX = ../../LaTeX/package.dhall

let renderAbbrevMonthYear =
      λ(date : dates.Date) →
        let month =
              merge
                { January = "Jan"
                , February = "Feb"
                , March = "Mar"
                , April = "Apr"
                , May = "May"
                , June = "June"
                , July = "July"
                , August = "Aug"
                , September = "Sept"
                , October = "Oct"
                , November = "Nov"
                , December = "Dec"
                }
                date.month

        in  "${month} ${Prelude.Natural.show date.year}"

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

let toItemize =
      λ(items : List Text) →
        LaTeX.concatMapSep
          [ LaTeX.newline ]
          Text
          ( λ(x : Text) →
              [ LaTeX.command
                  { name = "item", arguments = [] : List Text, newline = False }
              , LaTeX.text " ${x}"
              ]
          )
          items

let toSchoolLaTeX =
      λ(school : types.School) →
        let arguments =
              toKeyvalsArguments
                ( toMap
                    { name = school.name
                    , gpa = "${Double/show school.gpa}/4.0"
                    , loc = school.location
                    , from = renderAbbrevMonthYear school.dates.from
                    , to = renderAbbrevMonthYear school.dates.to
                    , major = school.major
                    , minor = Text/default school.minor
                    , awards = school.awards
                    }
                )

        in  [ LaTeX.command { name = "school", arguments, newline = True } ]

let toExperienceLaTeX =
      λ(exp : types.Experience.Type) →
        let position =
              merge
                { Progression =
                    λ(x : types.ProgressionPosition) → "${x.first} to ${x.last}"
                , Single = λ(x : Text) → x
                , None = ""
                }
                exp.position

        let arguments =
              toKeyvalsArguments
                ( toMap
                    { corp = exp.corporation
                    , from = renderAbbrevMonthYear exp.dates.from
                    , to =
                        merge
                          { Date = renderAbbrevMonthYear, Present = "Present" }
                          exp.dates.to
                    , pos = position
                    }
                )

        in  [ LaTeX.command { name = "experience", arguments, newline = True }
            , LaTeX.environment
                { name = "itemize"
                , arguments = [] : List Text
                , content = toItemize exp.bullets
                }
            ]

let toProjectLaTeX =
      λ(p : types.Project.Type) →
        let showYear = λ(x : dates.Date) → Prelude.Natural.show x.year

        let from = showYear p.dates.from

        let dates =
              merge
                { Date =
                    λ(x : dates.Date) →
                      if    Prelude.Natural.equal p.dates.from.year x.year
                      then  from
                      else  "${from} - ${showYear x}"
                , Present = "${from} - Present"
                }
                p.dates.to

        let arguments =
              toKeyvalsArguments
                (toMap { name = p.name, dates, summary = p.summary })

        in  [ LaTeX.command { name = "project", arguments, newline = False } ]

let toProjectsLaTeX =
      λ(projects : List types.Project.Type) →
        [ LaTeX.command
            { name = "titled", arguments = [ "Projects" ], newline = True }
        , LaTeX.environment
            { name = "itemize"
            , arguments = [] : List Text
            , content =
                LaTeX.concatMapSep
                  [ LaTeX.newline ]
                  types.Project.Type
                  toProjectLaTeX
                  projects
            }
        ]

let toSkillGroupLaTeX =
      λ(sg : types.SkillGroup) →
        let skills = sg.skills

        let latex =
              [ LaTeX.environment
                  { name = "groupitem"
                  , arguments = [ sg.name ]
                  , content = toItemize skills
                  }
              ]

        in  if    Prelude.List.null Text skills
            then  [] : List LaTeX.Type
            else  latex

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

        in  [ LaTeX.command { name = "award", arguments, newline = False } ]

let toSectionLaTeX =
      λ(section : types.Section) →
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
              λ(x : List types.Award) →
                [ LaTeX.environment
                    { name = "awards"
                    , arguments = [] : List Text
                    , content =
                        LaTeX.concatMapSep
                          [ LaTeX.newline ]
                          types.Award
                          toAwardLaTeX
                          x
                    }
                ]

        let toItem =
              λ(item : types.SectionItem) →
                merge
                  { School = toSchoolLaTeX
                  , Experience =
                      λ(x : types.Experience.Type) → toExperienceLaTeX x
                  , Projects = toProjectsLaTeX
                  , Skills = toSkills
                  , Awards = toAwards
                  }
                  item

        let data =
              Prelude.List.concatMap
                types.SectionItem
                LaTeX.Type
                toItem
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
              List/concatMap types.Section LaTeX.Type toSectionLaTeX sections

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

let package = (../packages.dhall).`latex-resume-2.5`

let resume = package.resumes.resume

let latex =
      package.resumes.toResume
        ( resume.content
            (   { cad = False
                , mechanical = False
                , instruments = False
                , manufacturing = False
                , sensor = True
                , cloud = True
                , robotics = True
                , machine_learning = True
                , vision = True
                , devops = False
                , functional_programming = False
                , programming = True
                , apps = False
                , webdev = False
                , problem_solving = True
                , creative = False
                , communication = True
                , reports = False
                , documentation = False
                , chart = False
                , planning = False
                , conflict_resolution = False
                , full = False
                , sailing = False
                }
              : resume.TagList.Type
            )
        )

in  latex

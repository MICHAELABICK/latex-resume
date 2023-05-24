let package = ../../dhall-packages/package.dhall

let resume = package.resumes.resume

let latex =
      package.resumes.toResume
        ( resume.content
            (   { cad = True
                , mechanical = True
                , instruments = True
                , manufacturing = True
                , sensor = True
                , cloud = False
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
                , documentation = True
                , chart = False
                , planning = True
                , conflict_resolution = False
                , full = False
                , sailing = False
                }
              : resume.TagList.Type
            )
        )

in  latex

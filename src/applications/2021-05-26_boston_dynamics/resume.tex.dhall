let package = (../packages.dhall).`latex-resume-2.0`

let resume = package.resumes.resume

let latex =
      package.resumes.toResume
        ( resume.content
            resume.TagList::{
            , cad = True
            , mechanical = True
            , sensor = True
            , cloud = True
            , robotics = True
            , machine_learning = True
            , vision = True
            , devops = True
            , programming = True
            , problem_solving = True
            , communication = True
            , documentation = True
            , planning = True
            }
        )

in  latex

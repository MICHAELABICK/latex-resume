let package = (../packages.dhall).`latex-resume-2.0`

let resume = package.resumes.resume

let latex =
      package.resumes.toResume
        ( resume.content
            resume.TagList::{
            , cad = True
            , mechanical = True
            , manufacturing = True
            , sensor = True
            , robotics = True
            , machine_learning = True
            , vision = True
            , programming = True
            , problem_solving = True
            , communication = True
            , documentation = True
            , planning = True
            }
        )

in  latex

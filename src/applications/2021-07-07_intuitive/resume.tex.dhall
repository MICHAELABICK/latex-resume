let package =
      https://raw.githubusercontent.com/MICHAELABICK/latex-resume/resume-v2.0.3/src/dhall-packages/package.dhall

let resume = package.resumes.resume

let latex =
      package.resumes.toResume
        ( resume.content
            resume.TagList::{
            , cad = True
            , mechanical = True
            , manufacturing = True
            , instruments = True
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

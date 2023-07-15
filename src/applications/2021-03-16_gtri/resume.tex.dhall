let package =
        https://raw.githubusercontent.com/MICHAELABICK/latex-resume/resume-v2.0.0/src/dhall-packages/package.dhall sha256:153df06f2e82ad98e8afb34e6e164559f5356ce2bd8a31960c9ab2ba7ca3de35
      ? https://raw.githubusercontent.com/MICHAELABICK/latex-resume/resume-v2.0.0/src/dhall-packages/package.dhall

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
            , programming = True
            , problem_solving = True
            }
        )

in  latex

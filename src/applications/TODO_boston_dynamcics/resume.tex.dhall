let package = ../../dhall-packages/package.dhall

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
            }
        )

in  latex

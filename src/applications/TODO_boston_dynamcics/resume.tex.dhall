let packages = ../../dhall-packages/package.dhall

let resume = packages.resumes.resume

let latex = packages.resumes.toResume resume.Tags resume.matchTags resume.content 

in latex
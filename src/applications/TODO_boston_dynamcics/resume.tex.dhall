let package = ../../dhall-packages/package.dhall

let resume = package.resumes.resume

let latex = package.resumes.toResume resume.Tags resume.matchTags resume.content 

in latex

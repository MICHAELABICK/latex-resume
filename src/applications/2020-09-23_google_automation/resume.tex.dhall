let package = (../packages.dhall).`latex-resume-1.1`

let resume = package.resumes.resume

let matchTags =
      λ(tags : resume.Tags) →
        let default = resume.matchTags tags

        in  default || tags.old == False && default == False

let latex = package.resumes.toResume resume.Tags matchTags resume.content

in  latex

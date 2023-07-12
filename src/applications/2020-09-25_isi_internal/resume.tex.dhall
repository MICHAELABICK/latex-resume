let package = (../packages.dhall).`latex-resume-1.3`

let resume = package.resumes.resume

let matchTags =
      λ(tags : resume.Tags) →
        let default = resume.matchTags tags

        in  default || tags.cad || tags.instruments || tags.devops

let latex = package.resumes.toResume resume.Tags matchTags resume.content

in  latex

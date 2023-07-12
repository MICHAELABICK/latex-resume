let packages = (../packages.dhall).`latex-resume-1.0`

let resume = packages.resumes.resume

let matchTags =
      λ(tags : resume.Tags) →
        let default = resume.matchTags tags

        in  default || tags.old == False && default == False

let latex = packages.resumes.toResume resume.Tags matchTags resume.content

in  latex

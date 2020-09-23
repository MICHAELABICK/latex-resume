let packages =
      ../../dhall-packages/package.dhall

let resume = packages.resumes.resume

let matchTags =
      λ(tags : resume.Tags) →
        let default = resume.matchTags tags

        in  default || tags.cad || tags.instruments

let latex = packages.resumes.toResume resume.Tags matchTags resume.content

in  latex

let package =
      https://raw.githubusercontent.com/MICHAELABICK/latex-resume/resume-v1.3.0/src/dhall-packages/package.dhall sha256:4d34520aa8599d54e17d003e0be383ff8db59ed8ba3d9bf9d872955569c93d1b

let resume = package.resumes.resume

let matchTags =
      λ(tags : resume.Tags) →
        let default = resume.matchTags tags

        in  default || tags.cad || tags.instruments || tags.devops

let latex = package.resumes.toResume resume.Tags matchTags resume.content

in  latex

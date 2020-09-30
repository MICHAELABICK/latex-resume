let package =
      https://raw.githubusercontent.com/MICHAELABICK/latex-resume/resume-v1.2.1/src/dhall-packages/package.dhall sha256:6c1ce50f52c52fad1295e9b92654bb0af7db812b55935a596202bc2072a4137e

let resume = package.resumes.resume

let matchTags =
      λ(tags : resume.Tags) →
        let default = resume.matchTags tags

        in  default || tags.old == False && default == False

let latex = package.resumes.toResume resume.Tags matchTags resume.content

in  latex

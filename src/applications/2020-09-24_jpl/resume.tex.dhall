let package =
      https://raw.githubusercontent.com/MICHAELABICK/latex-resume/resume-v1.2.0/src/dhall-packages/package.dhall sha256:2e88e3e7916010347d3a02621caada8a04e548be26116b6c1d3f9bf65611c293

let resume = package.resumes.resume

let matchTags =
      λ(tags : resume.Tags) →
        let default = resume.matchTags tags

        in  default || tags.cad || tags.instruments

let latex = package.resumes.toResume resume.Tags matchTags resume.content

in  latex

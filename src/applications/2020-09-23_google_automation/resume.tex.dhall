let package =
      https://raw.githubusercontent.com/MICHAELABICK/latex-resume/resume-v1.1.1/src/dhall-packages/package.dhall sha256:1765440f24d9d2db19e6dee2e5e56cc4de2f9307219a4316179bfa8d64e0b40c

let resume = package.resumes.resume

let matchTags =
      \(tags : resume.Tags) ->
        let default = resume.matchTags tags

        in default || ( tags.old == False && default == False )

let latex = package.resumes.toResume resume.Tags matchTags resume.content

in  latex

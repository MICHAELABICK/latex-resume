let package =
      https://raw.githubusercontent.com/MICHAELABICK/latex-resume/resume-v1.2.0/src/dhall-packages/package.dhall

let resume = package.resumes.resume

let matchTags =
      \(tags : resume.Tags) ->
        let default = resume.matchTags tags

        in default || ( tags.old == False && default == False )

let latex = package.resumes.toResume resume.Tags matchTags resume.content

in  latex

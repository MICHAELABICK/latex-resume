let packages =
      https://raw.githubusercontent.com/MICHAELABICK/latex-resume/resume-v1.0.2/src/dhall-packages/packages.dhall sha256:ccb9f566620642796def4c0290c5e0d3fe422379510f9a247ac7ded29f7b0727

let resume = packages.resumes.resume

let matchTags =
      \(tags : resume.Tags) ->
        let default = resume.matchTags tags

        in default || ( tags.old == False && default == False )

let latex = packages.resumes.toResume resume.Tags matchTags resume.content 

in latex

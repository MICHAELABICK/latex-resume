let packages = ../../dhall-packages/packages.dhall

let resume = packages.resumes.resume

let matchTags =
      \(tags : resume.Tags) ->
        let default = resume.matchTags tags
        in default || (tags.old == False && default == False)

let latex = packages.resumes.toResume resume.Tags matchTags resume.content 

in latex

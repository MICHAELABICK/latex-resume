let package =
      https://raw.githubusercontent.com/MICHAELABICK/latex-resume/resume-v1.5.1/src/dhall-packages/package.dhall

let resume = package.resumes.resume

let matchTags =
      λ(tags : resume.Tags.Type) →
        let default = resume.matchTags tags

        let any = False

        let keyworded =
                  tags.keyword == True
              &&  (     tags.programming
                    ||  tags.robotics
                    ||  tags.problem_solving
                    ||  tags.creative
                    ||  tags.communication
                  )

        let tagged = tags.keyword == False && False

        in  default || any || tagged || keyworded

let latex = package.resumes.toResume resume.Tags.Type matchTags resume.content

in  latex

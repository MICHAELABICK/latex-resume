let package = (../packages.dhall).`latex-resume-1.5`

let resume = package.resumes.resume

let matchTags =
      λ(tags : resume.Tags.Type) →
        let default = resume.matchTags tags

        let any =
                  tags.cad
              ||  tags.mechanical
              ||  tags.instruments
              ||  tags.manufacturing
              ||  tags.sensor
              ||  tags.cloud
              ||  tags.robotics
              ||  tags.machine_learning
              ||  tags.programming

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

let package = (../packages.dhall).`latex-resume-1.4`

let resume = package.resumes.resume

let matchTags =
      λ(tags : resume.Tags.Type) →
        let default = resume.matchTags tags

        let any =
                  tags.cloud
              ||  tags.machine_learning
              ||  tags.vision
              ||  tags.robotics

        let keyworded =
                  tags.keyword == True
              &&  (     tags.manufacturing
                    ||  tags.programming
                    ||  tags.problem_solving
                    ||  tags.creative
                    ||  tags.communication
                    ||  tags.planning
                    ||  tags.conflict_resolution
                  )

        let tagged = tags.keyword == False && tags.mechanical

        in  default || any || tagged || keyworded

let latex = package.resumes.toResume resume.Tags.Type matchTags resume.content

in  latex

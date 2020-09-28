let package =
      https://raw.githubusercontent.com/MICHAELABICK/latex-resume/resume-v1.4.0/src/dhall-packages/package.dhall sha256:262543ce3edc1da741b8f1abc0c2ba87f838eeacfe4d6464cae2361bf2589780

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

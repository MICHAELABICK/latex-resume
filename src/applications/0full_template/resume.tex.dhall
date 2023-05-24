let package = ../../dhall-packages/package.dhall

let resume = package.resumes.resume

let latex =
      package.resumes.toResume (resume.content resume.TagList::{ full = True })

in  latex

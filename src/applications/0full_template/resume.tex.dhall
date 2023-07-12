let package = (../packages.dhall).latex-resume

let resume = package.resumes.resume

let latex =
      package.resumes.toResume (resume.content resume.TagList::{ full = True })

in  latex

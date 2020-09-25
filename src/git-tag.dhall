let packages = ./dhall-packages/package.dhall

let resumeVersion = packages.semver.version 1 2 1

let renderedResumeVersion = "v${packages.semver.render resumeVersion}"

let resumeTag
    : packages.git-tag.GitTag
    = { tag = "resume-${renderedResumeVersion}"
      , message = "Resume ${renderedResumeVersion}"
      }

in  resumeTag

let packages = ./dhall-packages/package.dhall

let resumeVersion = packages.semver.version 2 2 0

let renderedResumeVersion = "v${packages.semver.render resumeVersion}"

let resumeTag
    : packages.git-tag.GitTag
    = { tag = "resume-${renderedResumeVersion}"
      , message = "Resume ${renderedResumeVersion}"
      }

in  resumeTag

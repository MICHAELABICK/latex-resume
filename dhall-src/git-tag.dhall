let packages = ./dhall-packages/packages.dhall

let resumeVersion =
      packages.semver.version 1 0 0

let renderedResumeVersion =
      "v${packages.semver.render resumeVersion}"

let resumeTag : packages.git-tag.GitTag =
      { tag = "resume-${renderedResumeVersion}"
      , message = "Resume ${renderedResumeVersion}"
      }

in resumeTag

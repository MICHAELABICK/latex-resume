default:
    make all

open TARGET:
     make build/applications/{{TARGET}}/resume.pdf
     evince build/applications/{{TARGET}}/resume.pdf

freeze:
    dhall freeze --cache --inplace src/applications/packages.dhall

just git-tag
    source ./git-tag

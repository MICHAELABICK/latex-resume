default:
    make all

freeze:
    dhall freeze --cache --inplace src/applications/packages.dhall

-- This maps patch semantic versions of the latex-resume dhall package
-- to minor versions so that we can patch multiple resumes with a single change
let latex-resume = ../dhall-packages/package.dhall

let `latex-resume-1.0` =
        https://raw.githubusercontent.com/MICHAELABICK/latex-resume/resume-v1.0.2/src/dhall-packages/packages.dhall sha256:cce1f5fdc240805d1fb0c6f1018feec6681561e5262b47390f2ccda221544116
      ? https://raw.githubusercontent.com/MICHAELABICK/latex-resume/resume-v1.0.2/src/dhall-packages/packages.dhall

let `latex-resume-1.1` =
        https://raw.githubusercontent.com/MICHAELABICK/latex-resume/resume-v1.1.1/src/dhall-packages/package.dhall sha256:bae68739a3c50996afba6bbc62c6154d4f014d8ae31c15c73d1af5214d3589bc
      ? https://raw.githubusercontent.com/MICHAELABICK/latex-resume/resume-v1.1.1/src/dhall-packages/package.dhall

let `latex-resume-1.2` =
        https://raw.githubusercontent.com/MICHAELABICK/latex-resume/resume-v1.2.1/src/dhall-packages/package.dhall sha256:8b3cbc42d53b1fc0c75d04510d0e9e12ed308a7b421f97ad4b66afa6d0f6651b
      ? https://raw.githubusercontent.com/MICHAELABICK/latex-resume/resume-v1.2.1/src/dhall-packages/package.dhall

let `latex-resume-1.3` =
        https://raw.githubusercontent.com/MICHAELABICK/latex-resume/resume-v1.3.0/src/dhall-packages/package.dhall sha256:1e3db4bbd268c8f8866f380b0d1ddffe55c0667f28e59f15b498b873dbdd2022
      ? https://raw.githubusercontent.com/MICHAELABICK/latex-resume/resume-v1.3.0/src/dhall-packages/package.dhall

let `latex-resume-1.4` =
        https://raw.githubusercontent.com/MICHAELABICK/latex-resume/resume-v1.4.0/src/dhall-packages/package.dhall sha256:91d5cd9532c08d44c92cc7c61c400bb5a32e13d7fd5e08ed1c1c49163ecce282
      ? https://raw.githubusercontent.com/MICHAELABICK/latex-resume/resume-v1.4.0/src/dhall-packages/package.dhall

let `latex-resume-1.5` =
        https://raw.githubusercontent.com/MICHAELABICK/latex-resume/resume-v1.5.1/src/dhall-packages/package.dhall sha256:29d83c9a80625553d68bbf3f5525c1b3b4e2b045b4a2bf97027c488676bd80ef
      ? https://raw.githubusercontent.com/MICHAELABICK/latex-resume/resume-v1.5.1/src/dhall-packages/package.dhall

let `latex-resume-2.0` =
        https://raw.githubusercontent.com/MICHAELABICK/latex-resume/resume-v2.0.3/src/dhall-packages/package.dhall sha256:70be4aec2588169029c00e99c05bd9a9cdbdab2ade06594866859e43fe8ee99c
      ? https://raw.githubusercontent.com/MICHAELABICK/latex-resume/resume-v2.0.3/src/dhall-packages/package.dhall

let `latex-resume-2.1` =
        https://raw.githubusercontent.com/MICHAELABICK/latex-resume/resume-v2.1.0/src/dhall-packages/package.dhall sha256:bf9f07a81ac3da89d5d854e148cabcb16070d427900180ecf2d297a92200ec05
      ? https://raw.githubusercontent.com/MICHAELABICK/latex-resume/resume-v2.1.0/src/dhall-packages/package.dhall

let `latex-resume-2.2` =
        https://raw.githubusercontent.com/MICHAELABICK/latex-resume/resume-v2.2.0/src/dhall-packages/package.dhall sha256:21321d2a4cdcb646aebea6568c9015e2ae46975c734c440329dd947754b6a13d
      ? https://raw.githubusercontent.com/MICHAELABICK/latex-resume/resume-v2.2.0/src/dhall-packages/package.dhall

let `latex-resume-2.3` =
        https://raw.githubusercontent.com/MICHAELABICK/latex-resume/resume-v2.3.0/src/dhall-packages/package.dhall sha256:e667e72a79e9e645649cda557f99700019402a79ce8e51668bcb3ab15a13fed7
      ? https://raw.githubusercontent.com/MICHAELABICK/latex-resume/resume-v2.3.0/src/dhall-packages/package.dhall

let `latex-resume-2.4` =
        https://raw.githubusercontent.com/MICHAELABICK/latex-resume/resume-v2.4.0/src/dhall-packages/package.dhall sha256:8a1f1b880c0077b469657b8d614bf384d75083ca2d5fdf30681c732234b192af
      ? https://raw.githubusercontent.com/MICHAELABICK/latex-resume/resume-v2.4.0/src/dhall-packages/package.dhall

let `latex-resume-2.5` = latex-resume

in  { latex-resume
    , `latex-resume-1.0`
    , `latex-resume-1.1`
    , `latex-resume-1.2`
    , `latex-resume-1.3`
    , `latex-resume-1.4`
    , `latex-resume-1.5`
    , `latex-resume-2.0`
    , `latex-resume-2.1`
    , `latex-resume-2.2`
    , `latex-resume-2.3`
    , `latex-resume-2.4`
    , `latex-resume-2.5`
    }

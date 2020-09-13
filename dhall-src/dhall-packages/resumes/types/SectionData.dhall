let Experience = ./Experience.dhall

in <
| Education :
    ./School.dhall
| Experiences :
    List Experience.Type
| Skills :
    ./SkillSectionData.dhall
| Awards :
    List ./Award.dhall
>

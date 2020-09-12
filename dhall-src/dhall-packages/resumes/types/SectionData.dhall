let Experience = ./Experience.dhall

in <
| Education :
    ./School.dhall
| Experiences :
    List Experience.Type
>

let Prelude = ./Prelude.dhall

let Text/concat = Prelude.Text.concat

let Text/concatMap = Prelude.Text.concatMap

let Bool/fold = Prelude.Bool.fold

let LaTeX = ./Type.dhall

let text = ./text.dhall

let command = ./command.dhall

let environment = ./environment.dhall

let document = ./document.dhall
let newline = ./newline.dhall

let render
    : LaTeX → Text
    = λ(x : LaTeX) →
        x
          Text
          { text = λ(t : Text) → t
          , command =
              λ(cmd : { name : Text, arguments : List Text, newline : Bool }) →
                let arguments =
                      Text/concatMap Text (λ(x : Text) → "{${x}}") cmd.arguments

                let newline = Bool/fold cmd.newline Text "\n" ""

                in  "\\${cmd.name}${arguments}${newline}"
          , environment =
              λ(env : { name : Text, content : List Text }) →
                let content = Text/concat env.content

                in  ''
                    \begin{${env.name}}
                    ${content}
                    \end{${env.name}}

                    ''
          , document = λ(doc : List Text) → Text/concat doc
          }

let example0 =
        assert
      :   render
            ( document [
                  , command
                      { name = "documentclass"
                      , arguments = [ "article" ]
                      , newline = True
                      }
                  , environment { name = "document", content = [
                  , command
                      { name = "section"
                      , arguments = [ "First" ]
                      , newline = True
                      }
                  , text "This is some text"
                  , newline
                  , environment
                      { name = "equation", content = [ text "1 + 1 = 2" ] }
                  , command
                      { name = "section"
                      , arguments = [ "Second" ]
                      , newline = True
                      }
                  , text "This is some "
                  , command
                      { name = "textbf"
                      , arguments = [ "more" ]
                      , newline = False
                      }
                  , text " text"
                  , newline
                  , environment
                      { name = "itemize"
                      , content =
                        [ command
                            { name = "item"
                            , arguments = [] : List Text
                            , newline = False
                            }
                        , text " item 1"
                        , newline
                        , command
                            { name = "item"
                            , arguments = [] : List Text
                            , newline = False
                            }
                        , text " item 2"
                        ]
                      } ] }
                  ]
            )
        ≡ ''
          \documentclass{article}
          \begin{document}
          \section{First}
          This is some text
          \begin{equation}
          1 + 1 = 2
          \end{equation}
          
          \section{Second}
          This is some \textbf{more} text
          \begin{itemize}
          \item item 1
          \item item 2
          \end{itemize}

          
          \end{document}

          ''

in  render

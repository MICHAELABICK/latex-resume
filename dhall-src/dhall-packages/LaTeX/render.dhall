let Prelude = ./Prelude.dhall

let Text/concatMap = Prelude.Text.concatMap

let LaTeX = ./Type.dhall

let text = ./text.dhall

let command = ./command.dhall

let environment = ./environment.dhall

let render
    : LaTeX → Text
    = λ(x : LaTeX) →
        x
          Text
          { text = λ(t : Text) → t
          , command =
              λ(cmd : { name : Text, arguments : List Text }) →
                let arguments =
                      Text/concatMap Text (λ(x : Text) → "{${x}}") cmd.arguments

                in  ''
                    \${cmd.name}${arguments}
                    ''
          , environment =
              λ(env : { name : Text, content : List Text }) →
                let content = Text/concatMap Text (λ(x : Text) → x) env.content

                in  ''
                    \begin{${env.name}}
                    ${content}
                    \end{${env.name}}\n
                    ''
          }

let example0 =
        assert
      :   render
            ( environment
                { name = "document"
                , content =
                  [
                  , command { name = "section", arguments = [ "First" ] }
                  -- , text "This is some text"
                  -- , 
                  ]
                }
            )
        ≡ ''
          \begin{document}
          \section{First}

          \end{document}\n
          ''

in  render

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2016/09/01 custom resume class]
\LoadClass[10pt]{article}

\input{pro_letterhead}

\RequirePackage{keyval}
\RequirePackage{xparse}

% Load enumitem for custom list formatting
\RequirePackage{enumitem}
% Remove space between list items
\setlist{itemsep=-0.3em}

% Load titesec for custom section formatting
\RequirePackage{titlesec}

% Reformat sections
\titleformat{\section}{\Large\scshape}{}{0em}{}
  [\titlerule]
\titlespacing*{\section}{0em}{1em}{.2em}

\titleformat{\subsection}{\large\scshape}{}{0em}{}
\titlespacing*{\subsection}{0em}{0em}{.2em}

% Create command for dated sections
\newcommand{\datedsection}[2]{
  \section[#1]{#1 \hfill #2}
}
\newcommand{\datedsubsection}[2]{
  \subsection[#1]{#1 \hfill #2}
}

% Schools Environment
% Create a environment to list schools
% https://tex.stackexchange.com/questions/61448/working-with-margins
% https://tex.stackexchange.com/questions/130097/automatically-set-description-list-labelwidth-based-on-widest-label
\newlength{\schoolwd}
\newlength{\schoolindent}
\setlength{\schoolindent}{0em}
\newenvironment{schools}[1]
  {\settowidth{\schoolwd}{\textbf{#1:}}%
   \begin{description}[leftmargin=\dimexpr\schoolwd+\schoolindent+.5em\relax,
     labelindent=0pt,labelsep=.5em,
     labelwidth=\schoolwd,align=right,
     itemindent=-\schoolindent,
     font=\normalfont\textsc]}
  {\end{description}}

% School  Macro
\define@key{school}{name}{\def\sch@name{#1}}
\define@key{school}{loc}{\def\sch@loc{#1}}
\define@key{school}{from}{\def\sch@from{#1}}
\define@key{school}{to}{\def\sch@to{#1}}
\define@key{school}{major}{\def\sch@major{#1}}
\define@key{school}{minor}{\def\sch@minor{#1}}
\define@key{school}{year}{\def\sch@year{#1}}
\define@key{school}{gpa}{\def\sch@gpa{#1}}
\define@key{school}{grad}{\def\sch@grad{#1}}
\DeclareDocumentCommand{\school}{m}{
  \begingroup
    % Key Defaults + New Ones
    \setkeys{school}{name={},loc={},from={},to={},major={},minor={},year={},gpa={},grad={},#1}
    % Define the macro
    \item [\sch@from - \sch@to] \textbf{\sch@major Major, \sch@minor Minor \textbar} GPA \sch@gpa\\
      \textbf{\sch@name}, \sch@loc\\
      Awards and misc. go here\\
      2\textsuperscript{nd} Year Junior, Expected Graduation \sch@grad
  \endgroup
}

% This is old, using tables. Left here if I want to go back later
% School (Row) Macro
% \define@key{school}{name}{\def\sch@name{#1}}
% \define@key{school}{loc}{\def\sch@loc{#1}}
% \define@key{school}{from}{\def\sch@from{#1}}
% \define@key{school}{to}{\def\sch@to{#1}}
% \define@key{school}{major}{\def\sch@major{#1}}
% \define@key{school}{minor}{\def\sch@minor{#1}}
% \define@key{school}{year}{\def\sch@year{#1}}
% \define@key{school}{gpa}{\def\sch@gpa{#1}}
% \define@key{school}{grad}{\def\sch@grad{#1}}
% \DeclareDocumentCommand{\school}{m}{
%   \begingroup
%     % Key Defaults + New Ones
%     \setkeys{school}{name={},loc={},from={},to={},major={},minor={},year={},gpa={},grad={},#1}
%     % Define the macro
%     \textsc{\sch@from} - \textsc{\sch@to} & \textbf{\sch@major Major, \sch@minor Minor \textbar} GPA \sch@gpa\newline
%     \textbf{\sch@name}, \sch@loc\newline
%     Awards and misc. go here\newline
%     2\textsuperscript{nd} Year Junior, Expected Graduation \sch@grad\\
%   \endgroup
% }

% Create the experience macro, with keyval and xparse
% https://tex.stackexchange.com/questions/120037/xparse-and-key-value-arguments
% Key Definitions
\define@key{experience}{corp}{\def\exp@corp{#1}}
\define@key{experience}{pos}{\def\exp@pos{#1}}
\define@key{experience}{from}{\def\exp@from{#1}}
\define@key{experience}{to}{\def\exp@to{#1}}
\DeclareDocumentCommand{\experience}{m}{
  \begingroup
    % Key Defaults + New Ones
    \setkeys{experience}{corp={},pos={},from={},to={},#1}
    % Define the macro
    \subsection[\exp@corp]{
      \hfill \exp@from - \exp@to\\
      \textbf{\exp@corp \textbar} \exp@pos
    }
  \endgroup
}

% \newcommand{\experience}[3]{
%   \subsection[#1]{
%     \hfill #3\\
%     \textbf{#1 \textbar} #2
%   }
% }

% Create a environment to list skills
% https://tex.stackexchange.com/questions/61448/working-with-margins
% https://tex.stackexchange.com/questions/130097/automatically-set-description-list-labelwidth-based-on-widest-label
\newlength{\skillwd}
\newlength{\skillindent}
\setlength{\skillindent}{1em}
\newenvironment{skills}[1]
  {\settowidth{\skillwd}{\textbf{#1:}}%
   \begin{description}[leftmargin=\dimexpr\skillwd+\skillindent+.5em\relax,
     labelindent=0pt,labelsep=.5em,
     labelwidth=\skillwd,align=right,
     itemindent=-\skillindent]}
  {\end{description}}
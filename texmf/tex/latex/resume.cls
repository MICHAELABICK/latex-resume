\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2016/09/01 custom resume class]
\LoadClass[10pt]{article}

\input{pro_letterhead}

% Custom section formatting
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
\newcommand{\experience}[3]{
  \subsection[#1]{
    \hfill #3\\
    \textbf{#1 \textbar} #2
  }
}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{pro_class}[2016/09/01 custom resume class]
\LoadClass{article}

% Reformat margins
\RequirePackage[letterpaper, portrait, margin=1in, top=1.5in,
  bottom=0.5in, headheight=0.9in, headsep=0.1in]{geometry}
% Remove numbering
\pagenumbering{gobble}

\RequirePackage{fancyhdr}
\pagestyle{fancy}
\RequirePackage{tabularx}

% Setup microtype package
\RequirePackage[activate={true,nocompatibility},final,tracking=true,kerning=true,spacing=true,factor=1100,stretch=10,shrink=10]{microtype}
% activate={true,nocompatibility} - activate protrusion and expansion
% final - enable microtype; use "draft" to disable
% tracking=true, kerning=true, spacing=true - activate these techniques
% factor=1100 - add 10% to the protrusion amount (default is 1000)
% stretch=10, shrink=10 - reduce stretchability/shrinkability (default is 20/20)
\SetTracking{encoding={*}, shape=sc}{0}

\fancyhead{} % clear all fields
\fancyhead[L]{
  \begin{tabularx}{\textwidth}{Xlr}
    \huge{\textsc{Michael A. Bick}}
    & \begin{tabular}{l}350 Ferst Drive\\
      329889 Georgia Tech Station\\
      Atlanta, GA 30332-1295\\
      US Citizen\end{tabular}
    & \begin{tabular}{r}(747)-227-6723\\
      michael.bick@gatech.edu\end{tabular}
  \end{tabularx}
}
\renewcommand{\headrulewidth}{0.4pt}

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

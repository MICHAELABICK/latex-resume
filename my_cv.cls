\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{my_cv}[2016/09/01 custom CV class]
\LoadClass{article}

% Reformat margins
\usepackage[letterpaper, portrait, margin=1in, top=0.5in, bottom=0.5in]{geometry}
% Remove numbering
\pagenumbering{gobble}
\RequirePackage{tabularx}

% Setup microtype package
\usepackage[activate={true,nocompatibility},final,tracking=true,kerning=true,spacing=true,factor=1100,stretch=10,shrink=10]{microtype}
% activate={true,nocompatibility} - activate protrusion and expansion
% final - enable microtype; use "draft" to disable
% tracking=true, kerning=true, spacing=true - activate these techniques
% factor=1100 - add 10% to the protrusion amount (default is 1000)
% stretch=10, shrink=10 - reduce stretchability/shrinkability (default is 20/20)
\SetTracking{encoding={*}, shape=sc}{0}

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
    \textbf{#1} \textbar #2
  }
}
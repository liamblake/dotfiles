\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{assignment}[30/03/2021 LaTeX class for university assignments]

\ProcessOptions\relax
\LoadClass[11pt,a4paper]{article}

\RequirePackage[left=1cm,right=1cm,top=1cm,bottom=2cm]{geometry}

% TeX-Depot packages
\RequirePackage{tdepot}

% Sans serif
\renewcommand{\familydefault}{\sfdefault}

\newenvironment{enumalpha}{\begin{enumerate}[label=(\alph*)}{\end{enumerate}}
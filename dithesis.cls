% Template for M. Sc. (Tech.) degree programmes at the
% Faculty of Information Technology and Electrical Engineering
% at University of Oulu (CSE/BME/BA)
% 
% Authors: Mika Korhonen (original author), Pekka Pietikäinen,
% Christian Wieser, Teemu Tokola, Juha Kylmänen, Tuomas Holmberg and
% Tuomas Varanka
% If you make any improvements to this template, please use
% https://github.com/ouspg/cse-thesis
%
% Several inspirations come from from Aalto University
% aaltothesis.cls by Luis R.J. Costa

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{dithesis}[2025/06/09 Diploma Thesis Class]

% Load report class as the base
\LoadClass[12pt,a4paper]{report}

% --- Core packages only (minimal set) ---
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage{etoolbox}
\usepackage{ifthen}
\usepackage{xstring}

% --- Essential formatting packages needed for document structure ---
\usepackage[noindentafter]{titlesec}
\usepackage{titlecaps}
\usepackage{chngcntr}
\usepackage[useregional=text, british]{datetime2}
\usepackage{appendix}
\usepackage{newfile}

% Footnotes in longtable require it to be loaded before pdfx, otherwise
% should be in .sty
\usepackage{longtable}
\usepackage[a-1b,latxmp, mathxmp]{pdfx}[2017/05/18]
\hypersetup{
  unicode=true,
  pdfencoding=auto,
  hidelinks
}
% Compatibility with older TeX distributions, make it a 
% no-op if not already defined. Some day alt-text will
% end up in the PDF.
\providecommand{\alt}[1]{}
% --- Language option processing ---
\newcommand*{\MainLang}{}
\newcommand*{\OtherLangs}{}

\DeclareOption{english}{%
  \PassOptionsToPackage{main=english, finnish}{babel}%
  \renewcommand*{\MainLang}{english}%
  \renewcommand*{\OtherLangs}{finnish}%
}
\DeclareOption{finnish}{%
  \PassOptionsToPackage{main=finnish, english}{babel}%
  \renewcommand*{\MainLang}{finnish}%
  \renewcommand*{\OtherLangs}{english}%
}

\DeclareOption{print}{%
  \PassOptionsToPackage{left=4.5cm, right=2.0cm, top=2.5cm, bottom=3.0cm}{geometry}
}
\DeclareOption{online}{%
  \PassOptionsToPackage{left=2.5cm, right=2.5cm, top=2.5cm, bottom=3.0cm}{geometry}
}
\ExecuteOptions{online}
\newcommand{\degreeprogrammeselection}{cse} % default to 'cse' (Tietotekniikka)
\newcommand{\thesistype}{Master} % default to 'Master' (Diplomityö)

\DeclareOption{cse}{\renewcommand{\degreeprogrammeselection}{cse}}
\DeclareOption{bme}{\renewcommand{\degreeprogrammeselection}{bme}}
\DeclareOption{ba}{\renewcommand{\degreeprogrammeselection}{ba}}
\ExecuteOptions{cse} % default

\DeclareOption{bachelor}{%
  \renewcommand{\thesistype}{bachelor}%
}
\DeclareOption{master}{%
  \renewcommand{\thesistype}{master}
}
\ExecuteOptions{master} % default to 'master' (Diplomi-insinööri)
\ProcessOptions\relax

\RequirePackage{geometry}

\newcommand*{\IfEng}[3]{\ifdefstring{#1}{english}{#2}{#3}}%
\newcommand*{\IfFin}[3]{\ifdefstring{#1}{finnish}{#2}{#3}}%
\newcommand{\IfLang}[4]{%
  \ifdefstring{#1}{#2}{#3}{#4}%
}

\newcounter{NAllPages}
\newcounter{NMainTxtPages}
\newcounter{NAppdxPages}
\newcommand*{\stor@maintxtpag@number}{%
  \immediate\write\@auxout{%
    \string\setcounter{NMainTxtPages}{\number\numexpr\thepage-1\relax}%
  }%
}

\newcommand{\startappendix}{%
  \stor@maintxtpag@number%
%  \renewcommand{\thechapter}{Appendix \arabic{chapter}}  % Custom numbering
  \renewcommand{\appendixname}{Appendix}
}

\AtEndDocument{%
  \immediate\write\@auxout{\string\setcounter{NAllPages}{\thepage}}%
}

\newcommand*{\shownumberofpages}{%
  \arabic{NAllPages}
}

\newcommand*{\shownumberofpageswithappendix}{%
  \ifnumequal{\value{NMainTxtPages}}{0}{\arabic{NAllPages}}%
  {\arabic{NMainTxtPages}+\arabic{NAppdxPages}}%
}%

\newif\ifwithdot
\withdottrue

\newcommand{\sectionnamedot}{\ifwithdot.\fi}
\newcommand{\chapnumformat}{\thechapter\sectionnamedot}
\newcommand{\secnumformat}{\thesection\sectionnamedot}
\newcommand{\subsecnumformat}{\thesubsection\sectionnamedot}
\newcommand{\subsubsecnumformat}{\thesubsubsection\sectionnamedot}

% --- Miscellaneous ---

\newtoggle{writexmpdatafile}

\toggletrue{writexmpdatafile}

\newcommand{\CopyrightText}{}% variable; used for printing on page
\newcommand{\MetaCopyrightText}{}%
\newcommand{\pdfCopyrightURL}{}%
\newcommand{\copyrighttext}[2]{%
  \renewcommand{\MetaCopyrightText}{#1}%
  \renewcommand{\CopyrightText}{#2}%
  \makeatletter
  \@ifundefined{doclicenseURL}{}{\renewcommand{\pdfCopyrightURL}{\doclicenseURL}}%
  \makeatother
}%

\newcommand*{\spc}{\noexpand\sep}%

\newcommand{\makemetadata}{%
  \iftoggle{writexmpdatafile}{%
    % Write the metadata into file .xmpdata, which is included in the PDF/A file
	\newoutputstream{xmpdata}%
	\openoutputfile{\jobname.xmpdata}{xmpdata}%
	\addtostream{xmpdata}{\noexpand\Title {\metadatatitle}}%
	\addtostream{xmpdata}{\noexpand\Author {\getauthorsmetadata}}%
        \addtostream{xmpdata}{\noexpand\Copyright {\MetaCopyrightText}}%
 	\addtostream{xmpdata}{\noexpand\CopyrightURL {\pdfCopyrightURL}}
		\IfFin{\MainLang}{%
          \addtostream{xmpdata}{\noexpand\Subject {\tiivistelmametadata}}%
          \addtostream{xmpdata}{\noexpand\Keywords[fi] {\avainsanatmetadata%
              \noexpand\sep[en] \keywordsmetadata}}%
        }{%
          \addtostream{xmpdata}{\noexpand\Subject {\abstractmetadata}}%
          \addtostream{xmpdata}{\noexpand\Keywords[en] {\keywordsmetadata%
              \noexpand\sep[fi] \avainsanatmetadata}}%
        }%
  \closeoutputstream{xmpdata}%
  }{%
    % Write the metadata directly into the pdf file via hyperref keywords
	%\renewcommand*{\spc}{; }%
	%\hypersetup{%
	%  pdftitle={\maintitle},%
	%  pdfauthor={\ThesisAuthor},%
	%  pdfsubject={\abstracttext},%
	%  pdfcopyright={\MetaCopyrightText},%
	%  pdfkeywords={\keywords}%
	%}%
  }%
}%
%
\AtBeginDocument{%
  \IfLang{\MainLang}{finnish}{%
    \renewcommand{\metadatatitle}{\getotsikko}
  }{%
    \renewcommand{\metadatatitle}{\gettitle}
  }
  \makemetadata%
}%
%

\newcommand{\firstname}[1]{\def\firstnameA{#1}}
\newcommand{\lastname}[1]{\def\lastnameA{#1}}
\newcommand{\firstnametwo}[1]{\def\firstnameB{#1}}
\newcommand{\lastnametwo}[1]{\def\lastnameB{#1}}
\newcommand{\firstnamethree}[1]{\def\firstnameC{#1}}
\newcommand{\lastnamethree}[1]{\def\lastnameC{#1}}
\newcommand{\otsikko}[1]{\gdef\@otsikko{#1}}

\newcommand{\getotsikko}{\@otsikko}
\newcommand{\gettitle}{\@title}

\newcommand{\headertitlecap}{
  \IfLang{\MainLang}{english}{
    \let\oldsection\section
    \let\oldsubsection\subsection
    \renewcommand{\section}[1]{\oldsection{\texorpdfstring{\titlecap{##1}}{##1}}}
    \renewcommand{\subsection}[1]{\oldsubsection{\texorpdfstring{\titlecap{##1}}{##1}}}
  }{}
}

\newcommand{\keywordsmetadata}{}%
\newcommand{\keywords}[1]{\renewcommand*{\keywordsmetadata}{#1}}

\newcommand{\avainsanatmetadata}{}%
\newcommand{\avainsanat}[1]{\renewcommand*{\avainsanatmetadata}{#1}}

% Define abstract content storage
\long\def\abstractmetadata{}
\long\def\tiivistelmametadata{}
% User-facing macros for defining abstract text
\long\def\abstract#1{\long\def\abstractmetadata{#1}}
\long\def\tiivistelma#1{\long\def\tiivistelmametadata{#1}}

% Add macros for thesis type in English and Finnish
\newcommand{\facultyname}{}
\newcommand{\degreeprogramme}{}
\newcommand{\degreeprogrammetitle}{}
\newcommand{\getauthorsabstract}{}
\newcommand{\thesistypetitle}{}
\newcommand{\thesistitle}{}
\newcommand{\metadatatitle}{}
\newcommand{\universityname}{}
\newcommand{\universitynameieee}{}
\newcommand{\pagelabel}{}
\newcommand{\abstracttitle}{}
\newcommand{\headerforeword}{}
\newcommand{\headerabbreviations}{}
\newcommand{\tocname}{}
\newcommand{\mybibname}{}
\newcommand{\cityname}{}
\newcommand{\countryname}{}
\newcommand{\keywordsline}{}
\newcommand{\universitylogo}{Figures/logo-en.png}

% --- End centralized definitions ---

%Title page
\newcommand{\maketitlepage}{
  \sloppy

  \selectlanguage{\MainLang}
  {
    \centering
    \includegraphics*[width=0.22\textwidth]{\universitylogo}\\
    {\sffamily\fontsize{8}{10pt}\selectfont \MakeUppercase{\facultyname} \\}
    \vspace{70 mm}
    {\textbf{\fontsize{16}{19pt}\selectfont \getauthorstitle}\\}
    \vspace{12 mm}
    {\textbf{\fontsize{18}{22pt}\selectfont \MakeUppercase{\thesistitle} \\}}
    \vfill
    {\fontsize{14}{17}\selectfont \thesistypetitle
    \\ \degreeprogrammetitle \\ \DTMToday \\}
    \vspace{1cm}
  \clearpage
  }
}  

\newcommand{\makecopyrightpage}{%
  \ifx\CopyrightText\@empty
    % Do nothing if empty
  \else
    \newpage
    \thispagestyle{empty}%
    \noindent
    \CopyrightText\par%
    \cleardoublepage
  \fi
}%

\addtocontents{toc}{\protect\thispagestyle{empty}}
%Table of contents
% Commentary: Use \contents to generate the table of contents. Only chapters from Introduction onwards are numbered.
\newcommand{\contents}{
  \newpage
  \renewcommand{\contentsname}{\tocname}%
  \addtocontents{toc}{\protect\contentsline{chapter}{\tocname}{}{page.\thepage}
  }
  \newlength{\temp}
  \setlength{\temp}{\parskip}
  \setlength{\parskip}{0mm}
  \tableofcontents
  \setlength{\parskip}{\temp}
}


\newcommand{\abstractauthors}{%
  {\textbf{\getauthorsabstractacta\ (\the\year) \thesistitle.} \universityname, \facultyname, \degreeprogramme, \thesistypetitle, \shownumberofpages~p.}
}

\newcommand{\abstractauthorsieee}{%
  {\getauthorsabstractieee, ``\thesistitle,'' \thesistypetitle, \degreeprogramme, \universitynameieee, Oulu, \countryname, \the\year.}
}

\newenvironment{thesisabstract}[1]{%
  \selectlanguage{#1}%
  \setcounter{NAppdxPages}{\numexpr\value{NAllPages}-\value{NMainTxtPages}\relax}
  \renewcommand*{\spc}{, }

  \cleardoublepage
  \noindent\abstractauthors
  \par\vspace{2\baselineskip}%

  {\centering\bfseries\fontsize{14}{17}\selectfont\MakeUppercase{\abstracttitle}\par}%
  \addtocontents{toc}{\protect\contentsline{chapter}{\abstracttitle}{}{page.\thepage}}
  \vspace{1\baselineskip}
  \makeatletter
  \@afterindentfalse\@afterheading
  \makeatother
  \begingroup
  \bfseries
  }{%
  \endgroup
  \par
  \vspace{1\baselineskip}\noindent
  \textbf{\keywordsline}
}

%chapters without page numbering
\newcommand{\header}[1]{
  \chapter*{#1}
  \thispagestyle{empty}
  \addtocontents{toc}{\protect\contentsline{chapter}{#1}{}{page.\thepage} }
}

% Helper macro to get first initial from a name
\newcommand{\getfirstinitial}[1]{\StrChar{#1}{1}.}

% Returns the list of authors, separated by \sep
\newcommand{\getauthors}[1]{%
  \ifdefined\firstnameB
    \ifdefined\firstnameC
      \firstnameA\ \lastnameA#1%
      \firstnameB\ \lastnameB#1%
      \firstnameC\ \lastnameC%
    \else
      \firstnameA\ \lastnameA#1%
      \firstnameB\ \lastnameB%
    \fi
  \else
    \firstnameA\ \lastnameA%
  \fi
}
\newcommand{\getauthorsmetadata}{\getauthors{\spc }}
\newcommand{\getauthorslist}{\getauthors{, }}
\newcommand{\getauthorstitle}{
  \begin{tabular}[t]{c}
  \getauthors{\\}
  \end{tabular}
}

%get authors for the abstract (Acta style: Surname F.)
\newcommand{\getauthorsabstractacta}{%
  \ifdefined\firstnameB
    \ifdefined\firstnameC
      \lastnameA\ \getfirstinitial{\firstnameA},\ %
      \lastnameB\ \getfirstinitial{\firstnameB},\ %
      \lastnameC\ \getfirstinitial{\firstnameC}%
    \else
      \lastnameA\ \getfirstinitial{\firstnameA},\ %
      \lastnameB\ \getfirstinitial{\firstnameB}%
    \fi
  \else
    \lastnameA\ \getfirstinitial{\firstnameA}%
  \fi
}
%get authors for the abstract (IEEE style: F. Lastname)
\newcommand{\getauthorsabstractieee}{%
  \ifdefined\firstnameB
    \ifdefined\firstnameC
      \getfirstinitial{\firstnameA}\ \lastnameA,\ %
      \getfirstinitial{\firstnameB}\ \lastnameB,\ %
      \getfirstinitial{\firstnameC}\ \lastnameC%
    \else
      \getfirstinitial{\firstnameA}\ \lastnameA,\ %
      \getfirstinitial{\firstnameB}\ \lastnameB%
    \fi
  \else
    \getfirstinitial{\firstnameA}\ \lastnameA%
  \fi
}

%signature at the bottom of foreword
\newcommand{\signature}{
  \DTMlangsetup[en-GB]{monthyearsep={,\space}}
  \par \vspace{1\baselineskip} \noindent
  \begin{flushleft} \cityname \DTMToday
  \end{flushleft}
  \par \noindent
  \begin{flushleft}
    \getauthors{\\}
  \end{flushleft}
}

\AtEndOfClass{%
  \RequirePackage{dithesis}%
}

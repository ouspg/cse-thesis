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
% inputenc/fontenc are pdflatex-isms; lualatex uses fontspec for encoding
\usepackage{iftex}
\ifPDFTeX
  \usepackage[utf8]{inputenc}
  \usepackage[T1]{fontenc}
\fi
\usepackage{etoolbox}
\usepackage{ifthen}
\usepackage{xstring}

% --- Essential formatting packages needed for document structure ---
\usepackage[noindentafter]{titlesec}
\usepackage{titlecaps}
\usepackage{chngcntr}
\usepackage{appendix}

% Footnotes in longtable require it to be loaded early (before most packages)
\usepackage{longtable}
\usepackage{graphicx}

% --- Language option processing ---
\newcommand*{\MainLang}{}
\newcommand*{\OtherLangs}{}

\DeclareOption{english}{%
  \PassOptionsToPackage{main=english, finnish}{babel}%
  \PassOptionsToPackage{useregional=text, warn=false, british}{datetime2}
  \renewcommand*{\MainLang}{english}%
  \renewcommand*{\OtherLangs}{finnish}%
}
\DeclareOption{finnish}{%
  \PassOptionsToPackage{main=finnish, english}{babel}%
  \PassOptionsToPackage{useregional=text, warn=false, finnish}{datetime2}
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
\RequirePackage{datetime2}

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

\newcommand{\CopyrightText}{}% variable; used for printing on page
\newcommand{\MetaCopyrightTextEn}{}% English dc:rights text
\newcommand{\MetaCopyrightTextFi}{}% Finnish dc:rights text
\newcommand{\pdfCopyrightURL}{}%
% \copyrighttext{<English metadata>}{<Finnish metadata>}{<copyright-page text>}
% The two metadata strings become a bilingual dc:rights in the PDF metadata;
% the page text is shown on the copyright page in the document's main language.
\newcommand{\copyrighttext}[3]{%
  \renewcommand{\MetaCopyrightTextEn}{#1}%
  \renewcommand{\MetaCopyrightTextFi}{#2}%
  \renewcommand{\CopyrightText}{#3}%
  \makeatletter
  \@ifundefined{doclicenseURL}{}{\renewcommand{\pdfCopyrightURL}{\doclicenseURL}}%
  \makeatother
}%

\newcommand*{\spc}{, }%

\ExplSyntaxOn
% Global scratch tl used to carry the resolved text out of the local group in
% \flattentext (a global assignment is not unwound at \group_end:).
\tl_new:N \g__dithesis_flat_tl
\NewDocumentCommand{\flattentext}{m m}{
  % #1 = macro to receive the flattened, PDF-string-safe text
  % #2 = macro containing the original abstract (e.g. \abstractmetadata)
  %
  % Produces a single-paragraph, plain-text version of the abstract for the XMP
  % metadata (dc:description, set via pdfsubject in \makemetadata):
  %   * \par and explicit line breaks become spaces;
  %   * runs of spaces are collapsed and the ends trimmed;
  %   * \texorpdfstring{<tex>}{<text>} is reduced to its <text> argument, so
  %     inline math written as \texorpdfstring{$E=mc^2$}{E = mc^2} has a clean
  %     text form in the metadata while the body keeps the real math.
  % Expand #2 once so a macro name resolves to its stored token list.
  \tl_set:No \l_tmpa_tl { #2 }
  % Replace every break *token* with a space. (\s in the regex only sees
  % character spaces, so these control sequences must be handled first.)
  \tl_replace_all:Nnn \l_tmpa_tl { \par } { ~ }
  \tl_replace_all:Nnn \l_tmpa_tl { \\ } { ~ }
  \tl_replace_all:Nnn \l_tmpa_tl { \newline } { ~ }
  \tl_replace_all:Nnn \l_tmpa_tl { \linebreak } { ~ }
  \regex_replace_all:nnN { \s+ } { \ } \l_tmpa_tl
  \tl_trim_spaces:N \l_tmpa_tl
  % Resolve \texorpdfstring to its text argument and fully expand to plain text.
  \group_begin:
    \cs_set:Npn \texorpdfstring ##1##2 {##2}
    \tl_gset:Ne \g__dithesis_flat_tl { \l_tmpa_tl }
  \group_end:
  \tl_set_eq:NN #1 \g__dithesis_flat_tl
}
\ExplSyntaxOff

\newcommand{\abstractflat}{}
\newcommand{\tiivistelmaflat}{}

\newcommand{\makemetadata}{%
  % Flatten the abstracts to PDF-string-safe, single-paragraph plain text.
  \flattentext\abstractflat\abstractmetadata
  \flattentext\tiivistelmaflat\tiivistelmametadata
  \hypersetup{%
    pdftitle={[fi]\getotsikko,
      [en]\gettitle},%
    pdfauthor={\getauthorslist},%
    % pdfsubject becomes dc:description. The value is read as a comma list to
    % support the [lang] tags, so each abstract is wrapped in braces to protect
    % the commas in its text; otherwise it is shredded into bogus rdf:li lines.
    pdfsubject={[en]{\abstractflat},[fi]{\tiivistelmaflat}},%
    pdfkeywords={[fi]\avainsanatmetadata,
                 [en]\keywordsmetadata},%
  }%
}
\AtBeginDocument{\makemetadata}

% pdfcopyright becomes dc:rights (a comma-separated langalt, so each language's
% text is braced to protect its internal commas, like pdfsubject above).
% This must run in begindocument/end, AFTER pdfmanagement-firstaid's own
% \AtBeginDocument hook, which -- when doclicense is loaded with hyperxmp
% disabled -- sets pdfcopyright to the single-language \doclicenseLongTextForHyperref
% and would otherwise overwrite ours. Setting it later lets us provide a proper
% bilingual dc:rights for both the CC and all-rights-reserved cases.
\AddToHook{begindocument/end}{%
  \ifdefempty{\MetaCopyrightTextEn}{}{%
    \hypersetup{pdfcopyright={[en]{\MetaCopyrightTextEn},%
                              [fi]{\MetaCopyrightTextFi}}}%
  }%
}

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
\newcommand{\thesistypetitle}{}
\newcommand{\thesistitle}{}
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
  \DTMlangsetup{showdayofmonth=false}
  \selectlanguage{\MainLang}
  {
    \centering
    \includegraphics*[width=0.22\textwidth,
      alt={University of Oulu logo}]{\universitylogo}\\
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
  \DTMlangsetup{showdayofmonth=true}

}  

\newcommand{\makecopyrightpage}{%
  \ifx\CopyrightText\@empty
    % Do nothing if empty
  \else
    \newpage
    \thispagestyle{empty}%
    \noindent
    % NoHyper suppresses link annotations on this page, avoiding a tagpdf 1.0b
    % off-by-one bug where the first annotation StructParent collides with the
    % last page's StructParents value in the ParentTree.
    \begin{NoHyper}%
    \CopyrightText\par%
    \end{NoHyper}%
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
  {\textbf{\getauthorsabstractacta\ (\the\year) \thesistitle.} \universityname, \facultyname, \degreeprogramme, \thesistypetitle, \shownumberofpages~\pagelabel}
}

\newcommand{\abstractauthorsieee}{%
  {\getauthorsabstractieee, ``\thesistitle,'' \thesistypetitle, \degreeprogramme, \universitynameieee, Oulu, \countryname, \the\year.}
}

\newenvironment{thesisabstract}[1]{%
  \selectlanguage{#1}%
  \setcounter{NAppdxPages}{\numexpr\value{NAllPages}-\value{NMainTxtPages}\relax}

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

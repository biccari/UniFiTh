%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% unifith.cls                                                     %%
%% version 1.2                                                     %%
%% 2019-08-27                                                      %%
%% author: Francesco Biccari                                       %%
%% contact: biccari@gmail.com                                      %%
%%                                                                 %%
%% This file is the LaTeX class for the thesis style               %%
%% of the "University of Florence"                                 %%
%%                                                                 %%
%% see README for license information and installation             %%
%% see unifith-doc.pdf for usage                                   %%
%% see the examples folder for document examples                   %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Identification %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}[2009/01/01]
\ProvidesClass{unifith}%
[2019/08/27 University of Florence thesis class]

\def\UFI@classVersion{1.2}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Options %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{xkeyval}
\newlength{\UFI@binding}
\newif\ifUFI@nodefaultfont \UFI@nodefaultfontfalse
\newif\ifUFI@romandiff \UFI@romandifffalse
\newif\ifUFI@customlanguage \UFI@customlanguagefalse
\newif\ifUFI@noexaminfo \UFI@noexaminfofalse
\newif\ifUFI@femaleauthor \UFI@femaleauthorfalse

\define@key[ufi]{}{noexaminfo}[]{\UFI@noexaminfotrue}
\define@key[ufi]{}{fem}[]{\UFI@femaleauthortrue}
\define@key[ufi]{}{nodefaultfont}[]{\UFI@nodefaultfonttrue}
\define@key[ufi]{}{romandiff}[]{\UFI@romandifftrue}
\define@key[ufi]{}{binding}[0pt]{\setlength{\UFI@binding}{#1}}
\define@key[ufi]{}{draft}[]{\PassOptionsToClass{draft}{book}}
\define@key[ufi]{}{oneside}[]{\PassOptionsToClass{oneside}{book}}
\define@key[ufi]{}{twoside}[]{}
\DeclareOptionX*{\ClassError{unifith}{Option '\CurrentOption'%
  \MessageBreak is not valid}{Remove '\CurrentOption' %
  from class options}}
\ProcessOptionsX[ufi]<>
\LoadClass[a4paper,11pt]{book}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Page layout %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[a4paper]{geometry}
\geometry{textwidth=396pt,
  textheight=641pt,
  marginparsep=12pt,
  bindingoffset=\UFI@binding,
  vmarginratio=55:89,
  includehead,
  marginparwidth=72pt,
  heightrounded}
  
\if@twoside\geometry{hmarginratio=55:89}\fi
  



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Some settings%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{ifxetex}
\ifxetex
  \RequirePackage{xltxtra}
\else
  \ifUFI@nodefaultfont\relax\else
    \RequirePackage[T1]{fontenc}
    \RequirePackage{textcomp}
    \RequirePackage{lmodern}
  \fi
\fi
\RequirePackage{caption}
\captionsetup{indention=\parindent,labelfont={small,bf},labelsep=period,%
  tableposition=top,textfont={small}}
\RequirePackage{graphicx}
\RequirePackage{color}
\RequirePackage{booktabs}
\RequirePackage{amsmath}
\RequirePackage{etoolbox}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fancy headers %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% this two lines remove the headers in the empty pages
%% (instead of loading the emptypage package)
\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
\thispagestyle{empty}\hbox{}\newpage\fi\fi}

\RequirePackage{fancyhdr}

%% definition of the main page style
\fancypagestyle{UFI@mainstyle}{%
\pagestyle{fancy}
\renewcommand{\chaptermark}[1]{\markboth{\ifnum \c@chapter>0 \thechapter.\ ##1 \else ##1 \fi}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection\ ##1}}
\fancyhf{}
\fancyhead[OR]{\small\bfseries\thepage}
\fancyhead[OL]{\small\bfseries\nouppercase{\rightmark}}
% This check is useful to avoid Warnings with oneside option
\if@twoside
\fancyhead[ER]{\small\bfseries\nouppercase{\leftmark}}
\fancyhead[EL]{\small\bfseries\thepage}
\fi
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0pt}}

%% ri-definition of the plain style (first page of the chapters)
\fancypagestyle{plain}{%
\renewcommand{\headrulewidth}{0pt}
\fancyhf{}
%\fancyfoot[C]{\small\scshape\thepage}
\fancyhead[OR]{\small\bfseries\thepage}
% This check is useful to avoid Warnings with oneside option
\if@twoside
\fancyhead[EL]{\small\bfseries\thepage}
\fi
}

\g@addto@macro\frontmatter{\pagestyle{UFI@mainstyle}}
\g@addto@macro\mainmatter{\pagestyle{UFI@mainstyle}}

% fancy marginnote (not activated yet)
% commands to redefine the marginpar command
% maybe in future I will remove the mnote command?
%\def \@marginparreset {%
%        \reset@font
%        \footnotesize
%        \itshape
%        \@setminipage
%}
%\long\def\@xmpar[#1]#2{%
%  \@savemarbox\@marbox{\raggedleft #1}%
%  \@savemarbox\@currbox{\raggedright #2}%
%  \@xympar}
%\long\def\@ympar#1{%
%  \@savemarbox\@marbox{\raggedleft #1}%
%  \@savemarbox\@currbox{\raggedright #1}%
%  \@xympar}
%  



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% numbering objects per chapters (e.g. 1.1, 1.2, ...) %%%%%%%%%%%%%%

\numberwithin{equation}{chapter}
\numberwithin{figure}{chapter}
\numberwithin{table}{chapter}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% redefinition of the \maketitle command to generate the titlepage %

%% GENERAL COMMANDS

% logo
\newif\ifUFI@unifilogo \UFI@unifilogofalse
\IfFileExists{unifilogo.pdf}{\UFI@unifilogotrue}{\RequirePackage{hyperref}}



\def\UFI@subtitle{}
\def\UFI@alttitle{}
\def\UFI@courseorganizerLabel{}
\def\UFI@courseLabel{}

\newcommand{\subtitle}[1]{\def\UFI@subtitle{#1}}
\newcommand{\alttitle}[1]{\def\UFI@alttitle{#1}}
\newcommand{\courseorganizer}[1]{\def\UFI@courseorganizerLabel{#1}}
\newcommand{\course}[1]{\def\UFI@courseLabel{#1}}

\def\UFI@copyyear{}
\newcommand{\copyyear}[1]{\def\UFI@copyyear{#1}}

\def\UFI@cycle{}
\newcommand{\cycle}[1]{\def\UFI@cycle{#1}}

\def\UFI@submitdate{}
\newcommand{\submitdate}[1]{\def\UFI@submitdate{#1}}
\let\AcademicYear\submitdate

\def\UFI@IDnumber{}
\newcommand{\IDnumber}[1]{\def\UFI@IDnumber{#1}}

%% Advisors
\newcount\UFI@advisorcount
\newtoks\UFI@advisortoks
\newcommand{\advisor}[1]{% 
  \ifnum\UFI@advisorcount=\z@ 
    \UFI@advisortoks={#1}% 
  \else 
    \UFI@advisortoks=\expandafter{\the\UFI@advisortoks\\[0.75mm]#1}% 
  \fi 
  \advance\UFI@advisorcount\@ne}

%% Co-Advisors or External Advisor 
\newcount\UFI@coadvisorcount
\newtoks\UFI@coadvisortoks
\newif\ifUFI@ext \UFI@extfalse
\newcommand{\coadvisor}[2][]{%
  \ifnum\UFI@coadvisorcount=\z@ 
    \UFI@coadvisortoks={#2}% 
  \else 
    \UFI@coadvisortoks=\expandafter{\the\UFI@coadvisortoks\\[0.75mm]#2}% 
  \fi 
  \advance\UFI@coadvisorcount\@ne
  \ifstrequal{#1}{ext}{\UFI@exttrue}{}}



%% Reviewers
\def\UFI@ReviewerLabel{}
\newcommand{\reviewerlabel}[1]{\def\UFI@ReviewerLabel{#1}}
 
\newcount\UFI@reviewercount
\newtoks\UFI@reviewertoks
\newcommand{\reviewer}[1]{%
  \ifnum\UFI@reviewercount=\z@ 
    \UFI@reviewertoks={#1}% 
  \else 
    \UFI@reviewertoks=\expandafter{\the\UFI@reviewertoks\\[0.75mm]#1}% 
  \fi 
  \advance\UFI@reviewercount\@ne}  
  
  
  
%% Directors
\newcount\UFI@directorcount
\newtoks\UFI@directortoks
\newcommand{\director}[1]{% 
  \ifnum\UFI@directorcount=\z@ 
    \UFI@directortoks={#1}% 
  \else 
    \UFI@directortoks=\expandafter{\the\UFI@directortoks\\[0.75mm]#1}% 
  \fi 
  \advance\UFI@directorcount\@ne}


%% Examiners
\newcount\UFI@examinercount
\newtoks\UFI@examinertoks
\newcommand{\examiner}[2][]{% 
  \ifnum\UFI@examinercount=\z@ 
    \UFI@examinertoks={#2 (\UFI@chairman\if|#1|\relax\else, #1\fi)}% 
  \else 
    \UFI@examinertoks=\expandafter{\the\UFI@examinertoks\\[0.75mm]#2 \if|#1|\relax\else (#1)\fi}% 
  \fi 
  \advance\UFI@examinercount\@ne}

\def\UFI@examdate{}
\newcommand{\examdate}[1]{\def\UFI@examdate{#1}}

\def\UFI@thesistype{}
\newcommand{\thesistype}[1]{\def\UFI@thesistype{#1}}

\def\UFI@versiondate{}
\newcommand{\versiondate}[1]{\def\UFI@versiondate{#1}}

\def\UFI@authoremail{}
\newcommand{\authoremail}[1]{\def\UFI@authoremail{#1}}

\def\UFI@website{}
\newcommand{\website}[1]{\def\UFI@website{#1}}

\def\UFI@ISBN{}
\newcommand{\ISBN}[1]{\def\UFI@ISBN{#1}}

\def\UFI@copyrightstatement{}
\newcommand{\copyrightstatement}[1]{\def\UFI@copyrightstatement{#1}}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% maketitle

\newcommand{\UFI@maketitleGeneral}{

% Errors:

\if|\UFI@courseorganizerLabel|\ClassError{unifith}{You must specify the course %
  organizer}{Example: \protect\courseorganizer{Scuola di dottorato di ...}}\fi
\if|\UFI@courseLabel|\ClassError{unifith}{You must specify the %
  course}{Example: \protect\course{Corso di Laurea Magistrale in Fisica}}\fi
\if|\UFI@submitdate|\ClassError{unifith}{You must specify the %
  thesis submission date}{Example: \protect\submitdate{August 2012} The date must be in the form Month(name) Year(number)}\fi
\if|\UFI@copyyear|\ClassError{unifith}{You must specify the %
  copyright year}{Example: \protect\copyyear{2012}}\fi
\if|\UFI@IDnumber|\ClassError{unifith}{You must specify your %
  ID number (matricola)}{Example: \protect\IDnumber{123456}}\fi
\if|\UFI@authoremail|\ClassError{unifith}{You must specify the email of the author}{%
  Example: \protect\authoremail{author@email.com}}\fi

% Titlepage:

	\begin{titlepage}
	
	\linespread{1}\selectfont

	% questa parbox forse è meglio eliminarla sostituendola con qualcosa di più semplice e che scali verticalmente.
	% infatti se metto tanti relatori, si sovrappone tutto.
    \newcommand{\UFI@parbox}[2][]{\hspace{1.72cm}\parbox[t][##1][t]{11.9cm}{##2}}
    \parindent=0pt
    \sffamily

    \vspace*{-25mm}
    %\hspace{-1cm}\includegraphics[width=6.5cm]{unifilogo}
    
	\ifUFI@unifilogo
		\parbox[b][3cm][c]{0.49\linewidth}{\hspace{-1cm}\includegraphics[width=6.5cm]{unifilogo.pdf}}
	\else
		\parbox[b][3cm][c]{0.49\linewidth}{\hspace{-1cm}
			\setlength{\unitlength}{1mm}
			\begin{picture}(65,27.3)(0,0)
			\small
			\put(0,0){\framebox(65,27.3)[0,0]{}}
			\put(2,23){\makebox(0,0)[l]{WARNING! ATTENZIONE!}}
			\put(2,18){\makebox(0,0)[l]{UniFi logo not found!}}
			\put(2,11){\href{http://biccari.altervista.org/c/informatica/latex/unifilogo.pdf}{Click here to download the UniFi logo}}
			\put(2,5.5){Then copy unifilogo.pdf in the folder}
			\put(2,1.5){of your main .tex file.}
			\end{picture}
		}
	\fi
	\hfill
	\parbox[b][2.9cm][c]{0.49\linewidth}{%
		\raggedleft
		\normalfont\footnotesize\scshape
		\textsc{\UFI@courseorganizerLabel}\\[3mm]
		\UFI@courseLabel
		\if?\UFI@cycle?\relax\else\\\UFI@cycle\fi
	}
    
    \nointerlineskip
    \vspace{\stretch{0.8}}
    \nointerlineskip

    \UFI@parbox{\huge\@title\par}
	
	\if|\UFI@subtitle|
	  \if|\UFI@alttitle|
	    \relax
	  \else
	    \vspace*{2cm}
	    \UFI@parbox{\huge\UFI@alttitle\par}
	  \fi
	\else
	  \vspace{0.4cm}
	  \UFI@parbox{\linespread{1.2}\selectfont\large\UFI@subtitle\par}
	\fi

    \vspace{\stretch{1}}

    

    \UFI@parbox{%
	    \ifUFI@femaleauthor
	      \textbf{\bfseries\UFI@CandidateLabelFemale}\\[1.5mm]
	    \else
	      \textbf{\bfseries\UFI@CandidateLabel}\\[1.5mm]
	    \fi
	    \@author\hspace{0.2cm} (\UFI@IDnumberLabel\ \UFI@IDnumber)
	}
	
	\vspace*{1cm}

    \UFI@parbox{%
        \ifcase\UFI@advisorcount
          \ClassError{unifith}{You must specify at least one advisor in the preamble}%
          {E.g. \protect\advisor{Prof. Name Surname}}
        \or
          \textbf{\bfseries\UFI@ThesisAdvisorLabel}\\[2mm]
        \else
          \textbf{\bfseries\UFI@ThesisAdvisorsLabel}\\[2mm]
        \fi
        \the\UFI@advisortoks
    }
    
    \vspace*{1cm}

    \UFI@parbox{\raisebox{-0.5cm}[0pt][0pt]{\UFI@AcademicYearLabel\ \UFI@submitdate}}
    
	\end{titlepage}
\clearpage
\UFI@composebacktitlepage
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Macro for the back of the title page %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\UFI@composebacktitlepage{%

{\thispagestyle{empty}
\linespread{1}\selectfont
\setlength{\parindent}{0pt}

\null
\vspace*{1cm}

\ifUFI@noexaminfo\relax
\else
\if?\UFI@examdate?
  \ifcase\UFI@examinercount
    \UFI@ThesisNotDefensedLabel%
  \else
    \ClassError{unifith}{You have specified one or more examiners but not
    the date of the final exam}{E.g. \protect\examdate{17 July 2015}}
  \fi
\else
  \ifcase\UFI@examinercount
    \ClassError{unifith}{You have specified the final exam date but no examiner}{E.g. \protect\examiner{Prof. Giulio Cesare}}
  \else
    \UFI@ThesisDefensedLabelA\ \UFI@examdate\\
    \UFI@ThesisDefensedLabelB:\\[2mm]
    \the\UFI@examinertoks%
  \fi
\fi
\fi

\vspace{1cm}

\ifcase\UFI@reviewercount
  \relax
\else
  \UFI@ReviewerLabel:\\[2mm]
  \the\UFI@reviewertoks%
\fi

\vfill

\hrulefill
\vspace{2mm}

\small
\textbf{\def\\{}\def\newline{}\@title} \\[0.75mm]
\if|\UFI@thesistype|\relax\else\UFI@thesistype.\fi\ \UFI@unifiname \\[0.75mm]
\if|\UFI@ISBN|\relax\else ISBN: \UFI@ISBN\fi\\[0.75mm]
\if|\UFI@copyrightstatement|\copyright\ \UFI@copyyear\ \@author. \UFI@allRightsReservedLabel\else\UFI@copyrightstatement\fi\\[1.5mm]

%Material for which the author is the copyright owner cannot be
%used without the written permission of the author.
%The permission to reproduce copyright protected material does not extend 
%to any material that is copyright of a third party; authorization to
%reproduce such material must be obtained from the copyright owners concerned.
%If you believe that a copyright infringement is present in this thesis,
%please contact the author, providing your name, contact details, full 
%details of the copyright infringement and advise whether you are the copyright
%owner or a representative of the copyright owner.\\

\UFI@unifithInformationLabel.\\

\if|\UFI@versiondate|
  \relax%
\else
  \UFI@versionLabel: \UFI@versiondate \\[2mm]%
\fi
\if|\UFI@website|
  \relax%
\else
  \UFI@websiteLabel: \@ifundefined{href}{\UFI@website}{\href{\UFI@website}{\UFI@website}} \\[2mm]%
\fi
\UFI@emailLabel: \@ifundefined{href}{\UFI@authoremail}{\href{mailto:\UFI@authoremail}{\UFI@authoremail}}\par

}
\cleardoublepage
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Choosing the right \maketitle according to the thesis type %%%%%%%

\renewcommand{\maketitle}{\UFI@maketitleGeneral}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% DEDICATION COMMAND %%
\providecommand*{\dedication}[1]{%
\cleardoublepage
\thispagestyle{empty}
\null\vspace{\stretch{0.26}}
\begin{flushright}
\textit{#1}
\end{flushright}
\vspace{\stretch{0.74}}\null}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ABSTRACT ENVIRONMENT %%
\newenvironment{abstract}[1][\UFI@AbstractLabel]
{\cleardoublepage\thispagestyle{plain}
\noindent{\Large\bfseries #1}\par\vspace{0.5cm}\noindent\ignorespaces}
{\null\ignorespacesafterend}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ACKNOWLEDGMENTS ENVIRONMENT %%
\newenvironment{acknowledgments}[1][\UFI@AcknowledgmentsLabel]
{\cleardoublepage\thispagestyle{plain}
\noindent{\Large\bfseries #1}\par\vspace{0.5cm}\itshape\noindent\ignorespaces}
{\null\ignorespacesafterend}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% LANGUAGE COMMANDS %%

\newcommand{\UFI@english}{%
  \newcommand{\UFI@CandidateLabel}{Candidate}
  \newcommand{\UFI@CandidateLabelFemale}{Candidate}
  \newcommand{\UFI@IDnumberLabel}{ID number}
  \newcommand{\UFI@ThesisAdvisorLabel}{Thesis Advisor}
  \newcommand{\UFI@ThesisAdvisorsLabel}{Thesis Advisors}
  \newcommand{\UFI@ThesisCoAdvisorLabel}{Co-Advisor}
  \newcommand{\UFI@ThesisCoAdvisorsLabel}{Co-Advisors}
  \newcommand{\UFI@ThesisExtAdvisorLabel}{External Advisor}
  \newcommand{\UFI@ThesisExtAdvisorsLabel}{External Advisors}
  \newcommand{\UFI@ThesisDirectorLabel}{Director}
  \newcommand{\UFI@ThesisDirectorsLabel}{Directors}
  \newcommand{\UFI@AcademicYearLabel}{Academic Year}
  \newcommand{\UFI@ThesisNotDefensedLabel}{Thesis not yet defended}
  \newcommand{\UFI@ThesisDefensedLabelA}{Thesis defended on}
  \newcommand{\UFI@ThesisDefensedLabelB}{in front of a Board of Examiners composed by}
  \newcommand{\UFI@chairman}{chairman}
  \newcommand{\UFI@PhDthesistype}{Ph.D. thesis}
  \newcommand{\UFI@Specializationthesistype}{Specialization thesis}
  \newcommand{\UFI@LaMthesistype}{Master's thesis}
  \newcommand{\UFI@Lauthesistype}{Bachelor's thesis}
  \newcommand{\UFI@MasterPthesistype}{First level master's thesis}
  \newcommand{\UFI@MasterSthesistype}{Second level master's thesis}
  \newcommand{\UFI@unifiname}{University of Florence}
  \newcommand{\UFI@versionLabel}{Version}
  \newcommand{\UFI@websiteLabel}{Website}
  \newcommand{\UFI@AcknowledgmentsLabel}{Acknowledgments}
  \newcommand{\UFI@AbstractLabel}{Abstract}
  \newcommand{\UFI@allRightsReservedLabel}{All rights reserved}
  \newcommand{\UFI@unifithInformationLabel}{This thesis has been typeset by \LaTeX\ and the UniFiTh class}
  \newcommand{\UFI@emailLabel}{Author's email}}

\newcommand{\UFI@italian}{%
  \newcommand{\UFI@CandidateLabel}{Candidato}
  \newcommand{\UFI@CandidateLabelFemale}{Candidata}
  \newcommand{\UFI@IDnumberLabel}{Matricola}
  \newcommand{\UFI@ThesisAdvisorLabel}{Relatore}
  \newcommand{\UFI@ThesisAdvisorsLabel}{Relatori}
  \newcommand{\UFI@ThesisCoAdvisorLabel}{Correlatore}
  \newcommand{\UFI@ThesisCoAdvisorsLabel}{Correlatori}
  \newcommand{\UFI@ThesisExtAdvisorLabel}{Relatore esterno}
  \newcommand{\UFI@ThesisExtAdvisorsLabel}{Relatori esterni}
  \newcommand{\UFI@ThesisDirectorLabel}{Direttore}
  \newcommand{\UFI@ThesisDirectorsLabel}{Direttori}
  \newcommand{\UFI@AcademicYearLabel}{Anno Accademico}
  \newcommand{\UFI@ThesisNotDefensedLabel}{Tesi non ancora discussa}
  \newcommand{\UFI@ThesisDefensedLabelA}{Tesi discussa il}
  \newcommand{\UFI@ThesisDefensedLabelB}{di fronte a una commissione esaminatrice composta da}
  \newcommand{\UFI@chairman}{presidente}
  \newcommand{\UFI@PhDthesistype}{Tesi di dottorato}
  \newcommand{\UFI@Specializationthesistype}{Tesi di Specializzazione}
  \newcommand{\UFI@LaMthesistype}{Tesi di Laurea Magistrale}
  \newcommand{\UFI@Lauthesistype}{Tesi di Laurea}
  \newcommand{\UFI@MasterPthesistype}{Tesi di Master di primo livello}
  \newcommand{\UFI@MasterSthesistype}{Tesi di Master di secondo livello}
  \newcommand{\UFI@unifiname}{Universit\`a degli Studi di Firenze}
  \newcommand{\UFI@versionLabel}{Versione}
  \newcommand{\UFI@websiteLabel}{Sito web}
  \newcommand{\UFI@AcknowledgmentsLabel}{Ringraziamenti}
  \newcommand{\UFI@AbstractLabel}{Sommario}
  \newcommand{\UFI@allRightsReservedLabel}{Tutti i diritti riservati}
  \newcommand{\UFI@unifithInformationLabel}{Questa tesi \`e stata composta con \LaTeX\ e la classe UniFiTh}
  \newcommand{\UFI@emailLabel}{Email dell'autore}}

  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% USEFUL COMMANDS %%

\newcommand*{\UFI@upbox}[1]{\textrm{\upshape#1}} 
\AtBeginDocument{

  \definecolor{unifiblue}{rgb}{0,0.322,0.576}

  % scritte in funzione della lingua del documento. Default inglese.
  \ifUFI@customlanguage
    \UFI@customlanguage
  \else
    \@ifpackageloaded{babel}{\csname UFI@\languagename\endcsname}{%
      \@ifpackageloaded{polyglossia}{\csname UFI@\languagename\endcsname}{\UFI@english}}
  \fi

  % degree 
  \providecommand{\degree}{\UFI@upbox{\textdegree}} 
  \providecommand{\g}{\degree} 

  % gradi Celsius
  \providecommand{\celsius}{\ensuremath{\UFI@upbox{\textdegree}\kern-\scriptspace\mathrm{C}}}
  \ifxetex
    \ProvideTextCommandDefault{\C}{\celsius}
  \else
  
    \providecommand{\C}{\celsius}
  \fi
  
  % Angstrom 
  \providecommand{\angstrom}{\UFI@upbox{\AA}} 
  \providecommand{\A}{\angstrom} 
  
  % micro 
  \providecommand{\micro}{\UFI@upbox{\textmu}} 
  
  % Ohm 
  \providecommand{\ohm}{\UFI@upbox{\textohm}} 
  
  % times (only math) 
  \providecommand{\x}{\times} 
  
  % measurement unit 
  \providecommand*{\un}[1]{\ensuremath{\mathrm{\,#1}}} 

  % Napier's number 
  \providecommand{\eu}{\ensuremath{\mathrm{e}}} 
  
  % imaginary unit 
  \providecommand{\iu}{\ensuremath{\mathrm{i}}} 
  
  % roman subscript 
  \providecommand*{\rb}[1]{\ensuremath{_\mathrm{#1}}} 
  
  % roman superscript 
  \providecommand*{\rp}[1]{\ensuremath{^\mathrm{#1}}} 

  % differential (only math)
  \ifUFI@romandiff
    \providecommand{\di}{\mathop{}\!\mathrm{d}}
  \else
    \providecommand{\di}{\mathop{}\!d}
  \fi
  
  % derivative and partial derivative (only math)
  % see http://www.guit.sssup.it/phpbb/viewtopic.php?p=42199#42199
  \providecommand{\der}[2]{\begingroup 
    \@tempswafalse\toks@={}\count@=\z@ 
    \@for\next:=#2\do 
      {\expandafter\check@var\next\@nil 
       \advance\count@\der@exp 
       \if@tempswa 
         \toks@=\expandafter{\the\toks@\,}% 
       \else 
         \@tempswatrue 
       \fi 
       \toks@=\expandafter{\the\expandafter\toks@\expandafter\partial\der@var}}%
    \frac{\partial\ifnum\count@=\@ne\else^{\number\count@}\fi#1}{\the\toks@}% 
    \endgroup} 
  \def\check@var{\@ifstar{\mult@var}{\one@var}} 
  \def\mult@var#1#2\@nil{\def\der@var{#2^{#1}}\def\der@exp{#1}} 
  \def\one@var#1\@nil{\def\der@var{#1}\chardef\der@exp\@ne}
  
  \providecommand{\pder}[2]{\begingroup
    \@tempswafalse\toks@={}\count@=\z@
    \@for\next:=#2\do
      {\expandafter\check@var\next\@nil
       \advance\count@\der@exp
       \if@tempswa
         \toks@=\expandafter{\the\toks@\,}%
       \else
         \@tempswatrue
       \fi
       \toks@=\expandafter{\the\expandafter\toks@\expandafter\partial\der@var}}%
    \frac{\partial\ifnum\count@=\@ne\else^{\number\count@}\fi#1}{\the\toks@}%
    \endgroup}
  \def\check@var{\@ifstar{\mult@var}{\one@var}} 
  \def\mult@var#1#2\@nil{\def\der@var{#2^{#1}}\def\der@exp{#1}} 
  \def\one@var#1\@nil{\def\der@var{#1}\chardef\der@exp\@ne}

  % subscript and superscript in text mode
  \DeclareRobustCommand*\textsubscript[1]{\@textsubscript{\selectfont#1}} 
  \def\@textsubscript#1{{\m@th\ensuremath{_{\mbox{\fontsize\sf@size\z@#1}}}}}
  \providecommand*{\tb}[1]{\textsubscript{#1}}
  \providecommand*{\tp}[1]{\textsuperscript{#1}}
}
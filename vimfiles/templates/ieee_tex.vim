\documentclass[10pt, journal, twocolumn]{IEEEtran}
                

%-------------------------------------------------------------------------------------------------------------
% PACKAGES
%-------------------------------------------------------------------------------------------------------------
        
\usepackage{cite}
\usepackage{graphicx}
\usepackage{listings}
\usepackage{color}
\usepackage{varioref}
\usepackage{caption}


%-------------------------------------------------------------------------------------------------------------
% Package config
%-------------------------------------------------------------------------------------------------------------

%caption
\captionsetup{width=.40\textwidth}

% varioref
%\renewcommand{\reftextbefore}{(above)}
%\renewcommand{\reftextfacebefore}{(above)}
%\renewcommand{\reftextafter}{(below)}
%\renewcommand{\reftextfaceafter}{(below)}
% what to use for \vpageref if it's on the same page. Default is "on this page". I prefer nothing. 
\renewcommand{\reftextcurrent}{}

% Colors
\definecolor{DarkGreen}{rgb}{0.2,0.65,0.1}
\definecolor{purple}{rgb}{0.8, 0, 0.8}

% Listings
\lstset{
numbers=left,
numberstyle=\scriptsize,
basicstyle=\small,
xleftmargin=15px,
xrightmargin=5px,
frame=single,
captionpos=b,
float=tbh,
escapeinside={(*@}{@*)},
breaklines=true,
breakatwhitespace=false,
prebreak=\mbox{{\color{blue}\tiny$\searrow$}},
showstringspaces=false,
tabsize=3,
aboveskip=20pt,
belowskip=20pt,
commentstyle=\em\color{DarkGreen},
stringstyle=\color{purple},
}


% Section numbering
\renewcommand{\thesubsubsection}{\thesubsection.\arabic{subsubsection}}


%-------------------------------------------------------------------------------------------------------------
% COMMAND DEFINITIONS
%-------------------------------------------------------------------------------------------------------------


\newcommand{\code}[1]{\texttt{#1}}


%-------------------------------------------------------------------------------------------------------------
% START OF DOCUMENT
%-------------------------------------------------------------------------------------------------------------

        
\begin{document}

%-------------------------------------------------------------------------------------------------------------
% Title, Author, etc.
%-------------------------------------------------------------------------------------------------------------

\title
{
	Title
}

\author
{
	\IEEEauthorblockN{%
		Brian Mearns~\IEEEmembership{Graduate Student Member,~IEEE}
	}
	\\
	\IEEEauthorblockA{%
		Dept. of Electrical and Computer Engineering, Boston University, Boston MA USA
	}
	\\
	bmearns@bu.edu
}
%end \author

% make the title
\maketitle  


%-------------------------------------------------------------------------------------------------------------
% Abstract and Keywords
%-------------------------------------------------------------------------------------------------------------

\begin{abstract}
Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Suspendisse porttitor vehicula dui. Quisque quis massa. Donec est. Sed vitae tellus ac libero tincidunt tempor. In faucibus lorem nec elit. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Praesent libero metus, fermentum ullamcorper, cursus a, egestas ut, neque. Donec vel sem. Nullam molestie lacus sit amet est. Donec placerat, risus eu ullamcorper imperdiet, massa ante commodo erat, lobortis sagittis enim diam ac ipsum. Praesent at lorem sollicitudin turpis pulvinar fringilla. Praesent mollis sapien ut diam. Suspendisse sagittis ante vitae leo. Nam pharetra velit vel metus. Fusce sollicitudin purus. Duis quis massa.
\end{abstract}

\begin{IEEEkeywords}
Lorem, ipsum, dolor, sit, amet
\end{IEEEkeywords}


%-------------------------------------------------------------------------------------------------------------
% MAIN TEXT
%-------------------------------------------------------------------------------------------------------------


%-------------------------------------------------------------------------------------------------------------
% Section - Introduction
%-------------------------------------------------------------------------------------------------------------
\section{Introduction}




%-------------------------------------------------------------------------------------------------------------
% BIBLIOGRAPHY
%-------------------------------------------------------------------------------------------------------------

\bibliographystyle{IEEEbib}
\bibliography{mybib}

%-------------------------------------------------------------------------------------------------------------
% Appendices
%-------------------------------------------------------------------------------------------------------------

\clearpage
\onecolumn

\begin{appendices}

\appendix{Some extra information}

\end{appendices}

%-------------------------------------------------------------------------------------------------------------
% INDICES
%-------------------------------------------------------------------------------------------------------------

\clearpage

\tableofcontents
\listoffigures
\lstlistoflistings



\end{document}


% Identification
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{csustThesis}[2022/05/11 Unofficial LaTeX Document Class for CSUST Bachelor Thesis]

% Preliminary declarations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 基本文档类及引入的宏包 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\LoadClass{article}
\RequirePackage[zihao=-4,heading=true,linespread=1.5]{ctex}
\RequirePackage[a4paper,top=25mm,bottom=20mm,left=30mm,right=20mm]{geometry}
\RequirePackage[colorlinks, linkcolor=blue, anchorcolor=yellow, citecolor=red]{hyperref}
\usepackage{amssymb, amsfonts, amsmath, amsthm, mathtools, mathrsfs, bm, calc} %% 和数学相关的一些宏包
\RequirePackage{bookmark}
\RequirePackage{graphicx}
\RequirePackage{setspace}
\RequirePackage{fancyhdr}
\RequirePackage{needspace}
\RequirePackage{lastpage}
\RequirePackage{chngcntr}  % 图标按章节编号
\RequirePackage{placeins}  % 图片仅限本章浮动
\RequirePackage{float}  % 浮动体的 H 选项
\RequirePackage{caption,subcaption}  % 标题控制
\RequirePackage{listings}  % 代码环境
\RequirePackage{xcolor}  % 颜色支持
\RequirePackage{tcolorbox}  % 文本框
\RequirePackage{longtable}  % 长表格
\RequirePackage{makecell}  % 表格线宽支持
\RequirePackage{booktabs}  % 三线表支持
\RequirePackage{bigstrut} %% 该宏包提供 \bigstrut 命令，可以增大表格的行间距
\RequirePackage[backend=biber,style=gb7714-2015,gbnamefmt=lowercase,refsegment=part,defernumbers=true,gbtype=true,]{biblatex}  % 支持参考文献
\RequirePackage{emptypage} %% 此宏包负责的任务是当每一章最后一页是偶数页时，设置空白
\RequirePackage{tikz}
\RequirePackage{indentfirst}
\RequirePackage[final]{pdfpages}
\RequirePackage{titlesec}  % titlespacing
\RequirePackage[titles]{tocloft}  % 用于设置目录条目
\RequirePackage{suffix}  % 定义 * 命令
\RequirePackage{varwidth}  
\RequirePackage{ulem}  % 删除线  


% Options

% More declarations

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 全局设置 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\IfFontExistsTF{宋体}{
    \setCJKmainfont{宋体}[AutoFakeBold={2.17}]  % 中文默认字体
	\setCJKfamilyfont{SimSun}[AutoFakeBold={2.17}]{宋体}
    \renewcommand\songti{\CJKfamily{SimSun}}
}{
    % TODO: 非 Windows 平台没有宋体的情况
}
\IfFontExistsTF{黑体}{
    \setCJKfamilyfont{SimHei}[AutoFakeBold={2.17}]{黑体}
    \renewcommand\heiti{\CJKfamily{SimHei}}
}{
    % TODO: 非 Windows 平台没有黑体的情况
}
\IfFontExistsTF{楷体}{
    \setCJKfamilyfont{KaiTi}[AutoFakeBold={2.17}]{楷体}
    \renewcommand\kaishu{\CJKfamily{KaiTi}}
}{
    % TODO: 非 Windows 平台没有楷体的情况
}
\newcommand\kaiti{\kaishu}
\setmainfont{Times New Roman}  % 西文默认字体

% 章节标题
\ctexset{
	section = {  % 一级标题
		format = \centering\heiti\zihao{-3},  % 黑体小三居中
		name = {第, 章},
	},
	subsection = {  % 二级标题
		format = \heiti\zihao{4},  % 黑体四号
	},
	subsubsection = {  % 三级标题
		format = \heiti\zihao{-4},  % 黑体小四
        indent = 2\ccwd,  % 缩进两字符
	}
}

% 定义标题命令
\newcommand{\chap}[1]{%
	\clearpage  % 每章另起一页
    \FloatBarrier  % 清除浮动体，也就是输出上一章的图表
    \vspace*{-.5\baselineskip}  % 调整章标题与页眉顶部的间距
	\section{#1}
}
\newcommand{\sect}[1]{\subsection{#1}}
\newcommand{\subsect}[1]{\subsubsection{#1}}

% 附录之后的章节标题及图表设置
\let\old@appendix\appendix
\renewcommand\appendix{
    \old@appendix
    \addcontentsline{toc}{section}{附录}  % 添加附录到目录
    \ctexset{section/format=\centering\heiti\zihao{3}}  % 黑体三号居中
    \def\chap##1{%
        \clearpage  % 每章另起一页
        \FloatBarrier  % 清除浮动体，也就是输出上一章的图表
        \vspace*{-.5\baselineskip}  % 调整章标题与页眉顶部的间距
        \stepcounter{section}
        \section*{附录\thesection\hspace{\ccwd}##1}
        \addcontentsline{toc}{subsection}{附录\thesection\hspace{\ccwd}##1}  % 为一级标题添加目录项
    }
    \def\sect##1{
        \setcounter{subsubsection}{0}
        \stepcounter{subsection}
        \subsection*{\thesubsection\hspace{\ccwd}##1}
        % \addcontentsline{toc}{subsubsection}{\thesubsection\hspace{\ccwd}##1}  % 为二级标题添加目录项
    }
    \def\subsect##1{
        \stepcounter{subsubsection}
        \subsubsection*{\thesubsubsection\hspace{\ccwd}##1}
    }
    \renewcommand{\thefigure}{\thesection\arabic{figure}}  % 图几几
    \renewcommand{\thetable}{\thesection\arabic{table}}  % 表几几
}

% 页眉页脚预设置
\pagestyle{fancy}
\fancyhf{}

% 页眉设置
\fancyhead[L]{  % 设置页眉左侧
    \raisebox{-.1cm}{\includegraphics[height=1.15cm]{figure/csust_logo_and_name2.pdf}}
}
\fancyhead[R]{\let\\=\relax\heiti\zihao{-5}\csustThesis@title}  % 设置页眉右侧

% 长度变量，定义各种封面时使用
\newlength{\maxwidth}
\newcommand{\titleBoxLen}{11cm}
\newcommand{\len}{8cm}
\newcommand{\llen}{6cm}

% 图表名格式设置
\captionsetup{font=small,labelsep=space}  % 图表标题设为五号字体、序号与图表名之间以空格分隔
\captionsetup[table]{font={small,bf},labelsep=space}  % 表标题设为五号加粗、表序与表名之间以空格分隔
\counterwithin{figure}{section}  % 图按章节编号
\counterwithin{table}{section}  % 表按章节编号
\renewcommand{\thefigure}{\thesection.\arabic{figure}}  % 图几.几
\renewcommand{\thetable}{\thesection-\arabic{table}}  % 表几-几

% 增大表格间距
% \renewcommand{\arraystretch}{1.2}

% 代码抄录的一系列设置
\lstset{
    basicstyle=\footnotesize\ttfamily, 
    flexiblecolumns, 
    numbers=left, 
    numbersep=5pt, 
    numberstyle=\tiny, 
    backgroundcolor=\color{white}, 
    frame=single, 
    breaklines=true, 
    showtabs=false, 
    showspaces=false, 
    showstringspaces=false, 
    keywordstyle=\color{teal}, 
    commentstyle=\color{blue}, 
    stringstyle=\color{red}, 
    numberstyle=\color{gray}, 
    tabsize=8, 
    breakatwhitespace=false, 
    postbreak=\mbox{\textcolor{violet}{$\hookrightarrow$}\space}
} %% 代码抄录的一系列设置

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 填写基本信息的命令 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 论文题目
\newcommand{\csustThesis@title}{题目}
\newcommand{\csustThesis@entitle}{Title}
\newcommand{\thesisTitle}[2]{
    \def\csustThesis@title{#1}
    \def\csustThesis@entitle{#2}
}

% 论文完成时间
\newcommand{\csustThesis@completeYear}{}
\newcommand{\csustThesis@completeMonth}{}
\newcommand{\csustThesis@completeDay}{}
\newcommand{\thesisCompleteTime}[3]{
    \def\csustThesis@completeYear{#1}
    \def\csustThesis@completeMonth{#2}
    \def\csustThesis@completeDay{#3}
}

% 学生姓名
\newcommand{\csustThesis@stuName}{}
\newcommand{\stuName}[1]{\def\csustThesis@stuName{#1}}

% 学生学号
\newcommand{\csustThesis@stuID}{}
\newcommand{\stuID}[1]{
    \def\csustThesis@stuID{#1}
}

% 学生班级
\newcommand{\csustThesis@stuClass}{}
\newcommand{\csustThesis@stuShortClass}{}
\newcommand{\stuClass}[2]{
    \def\csustThesis@stuClass{#1}
    \def\csustThesis@stuShortClass{#2}
}

% 学生专业
\newcommand{\csustThesis@stuMajor}{}
\newcommand{\stuMajor}[1]{
    \def\csustThesis@stuMajor{#1}
}

% 指导老师姓名
\newcommand{\csustThesis@supervisorName}{}
\newcommand{\supervisorName}[1]{
    \def\csustThesis@supervisorName{#1}
}

% 学生所在学院
\newcommand{\csustThesis@stuCollege}{}
\newcommand{\csustThesis@stuShortCollege}{}
\newcommand{\stuCollege}[2]{
    \def\csustThesis@stuCollege{#1}
    \def\csustThesis@stuShortCollege{#2}
}

% 诚信声明作者
\newcommand{\csustThesis@integrityStatement@author}{}
\newcommand{\integrityStatementAuthor}[1]{
    \def\csustThesis@integrityStatement@author{#1}
}

% 诚信声明年月日
\newcommand{\csustThesis@integrityStatement@year}{}
\newcommand{\csustThesis@integrityStatement@month}{}
\newcommand{\csustThesis@integrityStatement@day}{}
\newcommand{\integrityStatementDate}[3]{
    \def\csustThesis@integrityStatement@year{#1}
    \def\csustThesis@integrityStatement@month{#2}
    \def\csustThesis@integrityStatement@day{#3}
}

% 定义中英文摘要的命令
\newcommand{\csustThesis@abstract@title}{\csustThesis@title}
\newcommand{\csustThesis@abstract@entitle}{\MakeUppercase{\csustThesis@entitle}}
\newcommand{\abstractZhtitle}[1]{
    \def\csustThesis@abstract@title{#1}
}
\newcommand{\abstractEntitle}[1]{
    \def\csustThesis@abstract@entitle{#1}
}

% 定义外文译文翻译完成年月的命令
\newcommand{\csustThesis@translation@year}{}
\newcommand{\csustThesis@translation@month}{}
\newcommand{\translationDate}[2]{
    \def\csustThesis@translation@year{#1}
    \def\csustThesis@translation@month{#2}
}

% 定义开题报告完成年月的命令
\newcommand{\csustThesis@researchProposal@year}{}
\newcommand{\csustThesis@researchProposal@month}{}
\newcommand{\researchProposalDate}[2]{
    \def\csustThesis@researchProposal@year{#1}
    \def\csustThesis@researchProposal@month{#2}
}

% 定义任务书起止时间的命令
\newcommand{\csustThesis@taskRangeTime}{}
\newcommand{\taskRangeTime}[1]{
    \def\csustThesis@taskRangeTime{#1}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 制作封面的命令 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\makecover{
\begin{titlepage}

    \begin{center}
        \vspace*{1.2\baselineskip}
        \includegraphics{figure/csust_logo_and_name.pdf}
    \end{center}
    
    \begin{center}
        \vspace*{2.5\baselineskip}
        \mbox{\bfseries\fontsize{48bp}{2\hsize}\selectfont 毕业设计（论文）}
    \end{center}
    
    \begin{center}
        \vspace*{2cm}
        \begin{spacing}{1.8}
        \bfseries\zihao{-2}
        \settowidth{\maxwidth}{题目：}
        \makebox[\maxwidth][s]{题目：}\underline{\makebox[\titleBoxLen][l]{\phantom{幻影}}}
    
        \hspace*{\maxwidth}\underline{\makebox[\titleBoxLen][l]{\phantom{幻影}}}

        \vspace*{-2\baselineskip}  % 2.78cm
        \hspace*{\maxwidth}
        \begin{minipage}[t][2\baselineskip][t]{\titleBoxLen}
            \begin{center}\csustThesis@title\end{center}
        \end{minipage}
        \end{spacing}
    \end{center}
    
    \begin{center}
        \vspace*{-0.9cm}
        \begin{spacing}{1.63}
        \bfseries\zihao{3}
        \makebox[4em][s]{学生姓名}：\underline{\makebox[\len][c]{\csustThesis@stuName}}

        \makebox[4em][s]{学号}：\underline{\makebox[\len][c]{\csustThesis@stuID}}

        \makebox[4em][s]{班级}：\underline{\makebox[\len][c]{\csustThesis@stuClass}}

        \makebox[4em][s]{专业}：\underline{\makebox[\len][c]{\csustThesis@stuMajor}}

        \makebox[4em][s]{指导教师}：\underline{\makebox[\len][c]{\csustThesis@supervisorName}}
        \end{spacing}
    \end{center}
    
    \begin{center}
        \vspace*{1cm}
        \bfseries\zihao{3} 
        \makebox[4ex][c]{\csustThesis@completeYear} 年 
        \makebox[2ex][c]{\csustThesis@completeMonth} 月
    \end{center}
    
\end{titlepage}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 制作扉页的命令 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\maketitle{
\begin{titlepage}
    \vspace*{2.2cm}
    \begin{center}
    \begin{minipage}[t][7.7cm][t]{40em}
        \begin{center}\heiti\zihao{2}\csustThesis@title\end{center}
    \end{minipage}
    \end{center}
    
    
    \begin{center}
    \begin{spacing}{2.03}
    \bfseries\zihao{3}
        \makebox[4.5em][s]{学生姓名}：\underline{\makebox[\llen][c]{\csustThesis@stuName}}
    
        \makebox[4.5em][s]{学号}：\underline{\makebox[\llen][c]{\csustThesis@stuID}}
    
        \makebox[4.5em][s]{班级}：\underline{\makebox[\llen][c]{\csustThesis@stuClass}}
    
        \makebox[4.5em][s]{所在学院}：\underline{\makebox[\llen][c]{\csustThesis@stuCollege}}
    
        \makebox[4.5em][s]{指导教师}：\underline{\makebox[\llen][c]{\csustThesis@supervisorName}}
    
        \makebox[4.5em][s]{完成日期}：\underline{\makebox[\llen][c]{\makebox[4ex][c]{\csustThesis@completeYear} 年 \makebox[2ex][c]{\csustThesis@completeMonth} 月 \makebox[2ex][c]{\csustThesis@completeDay} 日}}
    \end{spacing}
    \end{center}
    \end{titlepage}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 定义制作诚信声明的命令 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\makeIntegrityStatement{
\begin{titlepage}
\begin{center}\heiti\zihao{-3}
    \ \\
    诚~~信~~声~~明\\
    \ \\
    \ \\
\end{center}
本人声明：

1、本人所呈交的毕业设计（论文）是在老师指导下进行的研究（设计）工作及取得的研究（设计）成果；

2、据查证，除了文中特别加以标注和致谢的地方外，毕业设计（论文）中不包含
\mbox{其他人}已经公开发表过的研究成果，也不包含为获得其他教育机构的学位而使用过材
料；

3、我承诺，本人提交的毕业设计（论文）中的所有内容均真实、可信。

\vspace*{4.2cm}
作者签名：\makebox[5cm][l]{\csustThesis@integrityStatement@author}
日期：
\makebox[4ex][c]{\csustThesis@integrityStatement@year} 年
\makebox[2ex][c]{\csustThesis@integrityStatement@month} 月
\makebox[2ex][c]{\csustThesis@integrityStatement@day} 日
\end{titlepage}
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 制作中英文摘要的环境及命令 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand\keywords[1]{\ \\ {\heiti\zihao{4}#1}}  % 黑体四号
\WithSuffix\newcommand\keywords*[1]{\ \\ {\bfseries\zihao{4}#1}}  % 四号加粗
\renewenvironment{abstract}{%
\begin{center}
    \heiti\zihao{3} \  \\ \csustThesis@abstract@title \\\ \\
    \zihao{-3}摘要 \\\ \\
\end{center}
}{%
\clearpage
}

\newenvironment{abstract*}{%
\begin{center}
    \bfseries\heiti\zihao{3} \ \\ \csustThesis@abstract@entitle \\\ \\
    \bfseries\zihao{-3}ABSTRACT \\\ \\
\end{center}
}{%
\clearpage
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 制作目录的命令 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\makecontents}{%
	\clearpage
    \vspace*{-.5\baselineskip}
	\pdfbookmark[1]{目录}{contents}  % 将目录添加到pdf书签
    \renewcommand\contentsname{\heiti\zihao{3}目\hspace{\ccwd}录}  % 设置目录字样
    \renewcommand\cftsecfont{\heiti}
    \renewcommand\cftsecleader{\cftdotfill{\cftdotsep}}  % 
	\tableofcontents
	\clearpage
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 制作外文译文及原文封面的命令 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\makeTranslationCover{
\begin{titlepage}
    \begin{center}
        \vspace*{1.2\baselineskip}
        \includegraphics{figure/csust_logo_and_name.pdf}
    
        \vspace*{2.5\baselineskip}
        \mbox{\zihao{-1}\bfseries 毕业设计（论文）资料附件：}
        
        \vspace{2\baselineskip}
        \mbox{\zihao{-0}\bfseries 外文译文及原文}

    
    {\zihao{-2} \phantom{一行}\\ \phantom{两行}\\}


    \begin{spacing}{1.63}
    \bfseries\zihao{3}
    \settowidth{\maxwidth}{学生姓名}
        \makebox[\maxwidth][s]{学生姓名}：\underline{\makebox[\len][c]{\csustThesis@stuName}}

        \makebox[\maxwidth][s]{学号}：\underline{\makebox[\len][c]{\csustThesis@stuID}}

        \makebox[\maxwidth][s]{班级}：\underline{\makebox[\len][c]{\csustThesis@stuClass}}

        \makebox[\maxwidth][s]{专业}：\underline{\makebox[\len][c]{\csustThesis@stuMajor}}

        \makebox[\maxwidth][s]{指导教师}：\underline{\makebox[\len][c]{\csustThesis@supervisorName}}
    \end{spacing}

    \vspace{3\baselineskip}

    {
        \bfseries\zihao{3} 
        \makebox[\widthof{\csustThesis@translation@year}][c]{\csustThesis@translation@year} 年 
        \makebox[\widthof{\csustThesis@translation@month}][c]{\csustThesis@translation@month} 月
    }

    \end{center}
    
    \end{titlepage}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 自定义开题报告和任务书的文本框 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newtcolorbox{ubox}[1][]
{
	#1,colback=white,arc=0mm,outer arc=0pt,width=1.01\linewidth,boxrule=.7pt,
	before upper={\parindent24bp},left=1.2pt,right=1.2pt,top=0mm,
}
\tcbuselibrary{breakable}  % 文本框断页

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 制作开题报告封面的命令 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\makeResearchProposalCover{
\begin{titlepage}

    \begin{center}
        \vspace*{3\baselineskip}
        \includegraphics[width=9.07cm,height=2.447cm]{figure/csustname_2640by711.png}
        \vspace*{\baselineskip}
    \end{center}
    
    \begin{center}
        \mbox{\bfseries\zihao{-0} 毕业设计(论文)开题报告}
    \end{center}
    
    \begin{center}
    \vspace*{2cm}
    \begin{spacing}{1.8}
    \bfseries\zihao{-2}
        \settowidth{\maxwidth}{题目：}
        \makebox[\maxwidth][s]{题目：}\underline{\makebox[\titleBoxLen][c]{\phantom{幻影}}}
    
        \hspace*{\maxwidth}\underline{\makebox[\titleBoxLen][l]{\phantom{幻影}}}

        \vspace*{-2\baselineskip}
        \hspace*{\maxwidth}
        \begin{minipage}[t][2\baselineskip][t]{\titleBoxLen}
            \begin{center}\csustThesis@title\end{center}
        \end{minipage}
        
    \end{spacing}
    \end{center}
    
    \begin{center}
    \vspace*{-0.9cm}
    \begin{spacing}{1.63}
    \bfseries\zihao{3}
    \settowidth{\maxwidth}{专业(全称)}
        \makebox[\maxwidth][s]{课题类别}：\underline{\makebox[\len][s]{\mbox{\quad 设计\ \ {$\square$ {\raisebox{.4ex}{\hspace{-.9em}\resizebox{.35cm}{!}{\bm{$\surd$} } } } } } \mbox{论文\ \ $\square$ \quad}}}

        \makebox[\maxwidth][s]{学生姓名}：\underline{\makebox[\len][c]{\csustThesis@stuName}}

        \makebox[\maxwidth][s]{学号}：\underline{\makebox[\len][c]{\csustThesis@stuID}}

        \makebox[\maxwidth][s]{班级}：\underline{\makebox[\len][c]{\csustThesis@stuClass}}

        \makebox[\maxwidth][s]{专业(全称)}：\underline{\makebox[\len][c]{\csustThesis@stuMajor}}

        \makebox[\maxwidth][s]{指导教师}：\underline{\makebox[\len][c]{\csustThesis@supervisorName}}
    \end{spacing}
    \end{center}
    
    \begin{center}
    \vspace*{1cm}
    \bfseries\zihao{3} 
    \makebox[4ex][c]{\csustThesis@researchProposal@year} 年 
    \makebox[2ex][c]{\csustThesis@researchProposal@month} 月
    \end{center}
    
    \end{titlepage}
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 制作任务书封面的命令 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\makeTaskBookCover{
\begin{titlepage}

    \begin{center}
        \vspace*{2\baselineskip}
        \includegraphics[scale=.106]{figure/csustname_2640by712.jpg}
    \end{center}
    
    \begin{center}
        \vspace{\baselineskip}
        \mbox{\bfseries\heiti\zihao{1} 毕业设计（论文）任务书}
    \end{center}

    \begin{center}
        \vspace{3.5\baselineskip}
        \zihao{4}
        \underline{\makebox[4cm][c]{\csustThesis@stuShortCollege}}
        \makebox{学院}
        \underline{\makebox[3.5cm][c]{\csustThesis@stuMajor}}
        \makebox{专业}
        \underline{\makebox[2.2cm][c]{\csustThesis@stuShortClass}}
        \makebox{班}
    \end{center}
    
    \settowidth{\maxwidth}{\zihao{-4}任务起止日期:}
    \begin{center}
        \vspace{1.1\baselineskip}
        \begin{spacing}{1.8}
        \zihao{4}
        \makebox[\maxwidth][l]{题\hspace{1.5em}目}\underline{\makebox[10cm][c]{\phantom{幻影}}}
    
        \hspace*{\maxwidth}\underline{\makebox[10cm][l]{\phantom{幻影}}}

        \vspace*{-2\baselineskip}
        \hspace*{\maxwidth}
        \begin{minipage}[t][2\baselineskip][t]{\titleBoxLen}
            \begin{center}\csustThesis@title\end{center}
        \end{minipage}
        \end{spacing}
    \end{center}

    \begin{center}
        \vspace{1.5\baselineskip}
        \zihao{-4}
        \makebox[\maxwidth][l]{任务起止日期：} \underline{\makebox[10cm][c]{\csustThesis@taskRangeTime}}
    \end{center}
    
    \begin{center}
        \vspace{3.2\baselineskip}
        \begin{spacing}{1.85}
        \zihao{4}
        \makebox[\maxwidth][s]{学生姓名}\underline{\makebox[4.15cm][c]{\csustThesis@stuName}}
        \makebox[5.85cm][r]{\mbox{学\hspace{.5em}号}\underline{\makebox[4.15cm][c]{\csustThesis@stuID}}}

        \makebox[\maxwidth][s]{指导教师}\underline{\makebox[4.15cm][c]{}}
        \makebox[5.85cm][r]{}

        \makebox[\maxwidth][s]{教研室主任}\underline{\makebox[4.15cm][c]{}}
        \makebox[5.85cm][r]{\makebox[4ex][c]{} 年 \makebox[2ex][c]{} 月 \makebox[2ex][c]{} 日审查}

        \makebox[\maxwidth][s]{院长}\underline{\makebox[4.15cm][c]{}}
        \makebox[5.85cm][r]{\makebox[4ex][c]{} 年 \makebox[2ex][c]{} 月 \makebox[2ex][c]{} 日批准}
        \end{spacing}
    \end{center}
    
    \end{titlepage}
}


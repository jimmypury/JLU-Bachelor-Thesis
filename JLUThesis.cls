%% start of file `JLUThesis.cls'.
%% Copyright 2022 Shem(shenjl2419@mails.jlu.edu.cn).
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License version 1.3c,
% available at http://www.latex-project.org/lppl/.


%-------------------------------------------------------------------------------
%                标识
%-------------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{JLUThesis}[2023/05/17 v1.3 jilin University Thesis document class]

% 论文使用A4纸，默认小四号字体
\LoadClass[UTF8, oneside, a4paper, 12pt]{ctexbook}

% 逻辑操作 Logical operation
\RequirePackage{ifthen}   % ifthen
\RequirePackage{pgffor}   % foreach

% 命令修改 Command modification
\RequirePackage{xpatch}   % xpatch

% 颜色 Color
\RequirePackage{xcolor}
\RequirePackage{tocloft}

% 表格 Table
\RequirePackage{multirow} % 合并表格
\RequirePackage{booktabs} % 三线表
\RequirePackage{makecell} % 自定义表格横线

% 图片 Figure
\RequirePackage{fancyhdr}
\RequirePackage{geometry}
\RequirePackage{graphicx}
% \RequirePackage{subfig} % 过时的子图
\RequirePackage{subcaption} % 新的子图宏包

% 代码 Code
\RequirePackage{algorithm}
\RequirePackage{algorithmicx}
\RequirePackage{algpseudocode}
% \RequirePackage[ruled]{algorithm2e} % 算法（带竖线），和上面的互斥
\RequirePackage{listings}

% 作图 Figure
\RequirePackage{tikz}
\RequirePackage{pgfplots}
\RequirePackage{pgfplotstable}

% 图片 Figure 标号
\RequirePackage{caption}

% 行距调节
\RequirePackage{setspace}

% 字体 Font
\RequirePackage{fontspec}
\RequirePackage{wasysym} % 特殊符号 - 带框对勾

% 封面 Cover
\RequirePackage{tabularray}
\RequirePackage{adjustbox}
\RequirePackage{calc}

% 引用 Cite
\RequirePackage[sort&compress]{gbt7714}
\RequirePackage{natbib}

% 脚注 Footnote
\RequirePackage{footmisc}
\RequirePackage{xunicode-addon} % 对带圈序号进行替换

% 缩写 Abbreviation
\RequirePackage{acronym}

% 超链接 Hyperlink
\RequirePackage{hyperref}

% 字体
\setmainfont[UprightFont=*,]{Times New Roman}
\setCJKfamilyfont{songti}[Path=fonts/, AutoFakeBold = {2.17}]{SimSun.ttc}
\setCJKfamilyfont{heiti}[Path=fonts/]{SimHei.ttf}

\renewcommand*{\songti}{\CJKfamily{songti}}
\renewcommand*{\heiti}{\CJKfamily{heiti}}

% 1.5 倍行距
\renewcommand{\baselinestretch}{1.75}

% 版面上空2.5cm，下空2.5cm，左空2.8cm，右空1.8cm
\geometry{a4paper, top = 25mm, bottom = 38mm, left = 28mm, right = 18mm}

%-------------------------------------------------------------------------------
%                加载配置文件
%-------------------------------------------------------------------------------

% cfg 样式设置
\input{JLUThesis.cfg}

% 科技文章的全角句点替换
% \catcode`\。=\active
% \newcommand{。}{．}

% 脚注格式 footnote
\renewcommand{\thefootnote}{\textcircled{\arabic{footnote}}}

% ref: https://blog.csdn.net/tsingke/article/details/105961016
\xeCJKDeclareCharClass{Default}{"24EA, "2460->"2473, "3251->"32BF} % 将中文字体声明为（西文）字体族
\newfontfamily\EnclosedNumbers{SimSun}
\AtBeginUTFCommand[\textcircled]{\begingroup\EnclosedNumbers} \AtEndUTFCommand[\textcircled]{\endgroup} % 放置钩子，只让带圈字符才需更换字体

% ref: https://zhuanlan.zhihu.com/p/74515148
\xpatchcmd\@makefntext
    {{\hss\@makefnmark}}
    {{\hss\@makefnmark@nosuperscript}\space}
    {}{\fail}
\def\@makefnmark@nosuperscript{\hbox{\normalfont\@thefnmark}}

% 超链接
\hypersetup{
    colorlinks=false,     % 开启超链接的自定义颜色
    linkcolor=blue,       % 超链接颜色（内部跳转）
    urlcolor=blue,        % 超链接颜色（外部网页链接）
    linktoc=section       % 目录章节名称超链接，但是页码不附超链接
}

% 图片标号
\captionsetup[figure]{
    labelsep=space,         % 去掉图片标号后面的冒号
    labelfont=bf,           % 图片标号黑体
    textfont=bf,            % 图片标题黑体
    % font=small,           % 图片标号字体大小
    % justification=center, % 图片标题居中
    % singlelinecheck=false % 图片标题超过一行，居左
}

% 表格标号
\captionsetup[table]{
    labelsep=space,         % 去掉表格标号后面的冒号
    labelfont=bf,           % 表格标号黑体
    textfont=bf,            % 表格标题黑体
    % font=small,           % 表格标号字体大小
    % justification=center, % 表格标题居中
    % singlelinecheck=false % 表格标题超过一行，居左
}

% 图片和公式标号

    % 全局
\ifnum \cfgstyle@fetindex = 0
    \counterwithout{figure}{chapter}
    \counterwithout{equation}{chapter}
    \counterwithout{table}{chapter}
\fi

    % 图 3.2 <figlabel>
\ifnum \cfgstyle@fetindex = 1
    \counterwithin{figure}{chapter}
    \counterwithin{equation}{chapter}
    \counterwithin{table}{chapter}
\fi

    % 图 3-2 <figlabel>
\ifnum \cfgstyle@fetindex = 2
    \RequirePackage{subcaption}
    \counterwithin{figure}{chapter}
    \counterwithin{equation}{chapter}
    \counterwithin{table}{chapter}
    \renewcommand {\thetable} {\thechapter{}-\arabic{table}} 
    \renewcommand {\thefigure} {\thechapter{}-\arabic{figure}}
\fi

% 引用
\ifnum \cfgstyle@citation = 0
    \bibliographystyle{gbt7714-numerical}   % 数字制
\else
    \bibliographystyle{gbt7714-author-year} % 作者年制
\fi

% 代码
\algdef{SE}[VARIABLES]{Variables}{EndVariables}
   {\algorithmicvariables}
   {\algorithmicend\ \algorithmicvariables}
\algnewcommand{\algorithmicvariables}{\textbf{global variables}}
\algdef{SE}[]{MultiProcedure}{EndMultiProcedure}
   {\algorithmicmultproc}
   {\algorithmicend\ \algorithmicmultproc}
\algnewcommand{\algorithmicmultproc}[1]{\textbf{procedure} #1}
\algnewcommand{\LineComment}[1]{\State \(\triangleright\) #1}
\algnewcommand{\And}{\(\textbf{and}\) }
\algnewcommand{\Or}{\(\textbf{or}\) }


%-------------------------------------------------------------------------------
%                页眉页脚设计
%-------------------------------------------------------------------------------
\setlength{\voffset}{-10mm}
% 页眉上边距
\setlength{\topmargin}{0mm}
\setlength{\headheight}{20pt}
% 页眉与正文间距
\setlength{\headsep}{7mm}
% 页脚与正文间距
\setlength{\footskip}{18pt}

\fancypagestyle{style@empty}{
	\fancyhf{}
	\renewcommand{\headrulewidth}{0pt}
	\renewcommand{\footrulewidth}{0pt}
}
\fancypagestyle{style@onlyfoot}{
    \fancyhf{}
	\fancyfoot[R]{\zihao{-5} \thepage}
	\renewcommand{\headrulewidth}{0pt}
	\renewcommand{\footrulewidth}{0pt}
}
\fancypagestyle{style@preliminary_gray}{
    \fancyhf{}
	\fancyfoot[R]{\color{gray} \zihao{-5} \thepage}
	\renewcommand{\headrulewidth}{0pt}
	\renewcommand{\footrulewidth}{0pt}
}
\fancypagestyle{style@preliminary_black}{
    \fancyhf{}
	\fancyfoot[R]{\color{black} \zihao{-5} \thepage}
	\renewcommand{\headrulewidth}{0pt}
	\renewcommand{\footrulewidth}{0pt}
}
\fancypagestyle{style@normal}{
	\fancyhead{}
	\fancyhead[C]{\zihao{-5} \songti \leftmark}
	\fancyfoot{}
	\fancyfoot[R]{\zihao{-5} \thepage}
	\renewcommand{\headrulewidth}{1pt}
	\renewcommand{\footrulewidth}{0pt}
    \renewcommand{\headruleskip}{2.5pt}
}
\fancypagestyle{plain}{
    \fancyhf{}
    \fancyfoot[R]{\color{gray} \zihao{-5} \thepage}
    \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\footrulewidth}{0pt}
}


%-------------------------------------------------------------------------------
%                封面设计
%-------------------------------------------------------------------------------
% reference: https://zhuanlan.zhihu.com/p/591074817
% Make a few tweaks to this code

% inner temp length
\newlength\@tempTitleHt
\newlength\@tempTitleMaxWd

\newlength{\lwtm}
\setlength{\lwtm}{\widthof{中文题目：}}

% length used as parameters， "Wd" is a shorthand for "Width"
% 设定不同的单行与多行的最大行长度
\newlength\titleSingleLineMaxWd
\newlength\titleMultiLineMaxWd
\newlength\titleLRExtraWd
\newlength\titleSepWd

\setlength\titleSingleLineMaxWd{0.6\textwidth}
\setlength\titleMultiLineMaxWd{0.6\textwidth}
\setlength\titleLRExtraWd{.4em}
\setlength\titleSepWd{0.1em}

% draw a fixed-width underline
\newcommand{\titleUnderline}{
  \rule[-.3em]{\titleSingleLineMaxWd + \titleLRExtraWd}{.5pt}
}

\newcommand{\@titleBox}[1]{
    \parbox[t]{\@tempTitleMaxWd}{#1}
}

% title content typesetter
\newcommand\titleBox[1]{
    \setlength\@tempTitleMaxWd\titleSingleLineMaxWd
    % Measure the total height of #1 subject to \titleSingleLineMaxWd.
    % Here \@titleBox is necessary when #1 contains "\\".
    \settototalheight\@tempTitleHt{\@titleBox{#1}}
    \ifdim\@tempTitleHt=0pt%
        % case 1: #1 causes empty output
        \titleUnderline
    \else
        % Change to LR mode, for inserting a zero-width box right after.
        \leavevmode
        % note: Use \normalbaseineskip instead of \baselineskip, 
        %       since the latter is set to 0pt inside tabular env.
        \ifdim\@tempTitleHt>\normalbaselineskip
            % case 2: #1 is fit for multilines, or contains `\\`, hence
            %         \titleMultiLineMaxWd is used instead, and the total 
            %         height of #1 subject to new max width is re-measured.
            \setlength\@tempTitleMaxWd\titleMultiLineMaxWd
            \settototalheight\@tempTitleHt{\@titleBox{#1}}
            % \rlap{\smash{...}} typesets content of its argument normally 
            % but sets it into a zero sized box. Here \@titleBox set 
            % (possiblly) multi-line text into a single box, since \smash 
            % only takes in argument spreading one line.
            %
            % Every line of title content needs an underline, hense we do
            % a loop to typeset one underline for every line the title 
            % content actually spreads.
            \hspace{-0.4cm}
            \rlap{\smash{
                \@titleBox
                {
                    \@whiledim\@tempTitleHt>0pt
                    \do{
                        \rlap{\titleUnderline}
                        \addtolength\@tempTitleHt{-\normalbaselineskip}
                    }
                }
            }}
            % % Insert h-offset to manually center the title content.
            \hspace{\dimexpr\titleLRExtraWd + .5\titleSingleLineMaxWd - .5\titleMultiLineMaxWd\relax}
            \@titleBox{\centering \linespread{2}\selectfont #1}
        \else
            % case 3: #1 is fit for one line
            \rlap{\titleUnderline}
            \@titleBox{\centering #1}
            \fi
    \fi
}
% main macro, using a simple table
\newcommand{\multilingualTitles}[2]{
    \noindent \centering \setstretch{2} 
    % 带有两列的表格，第一列使用左对齐方式，第二列使用固定宽度的自动换行方式。
    % 其中，\titleSepWd 和 \titleSingleLineMaxWd 分别表示列之间的间隔宽度和第二列的最大宽度。
    \begin{tabular}{l @{\hspace{\titleSepWd}} p{\titleSingleLineMaxWd + \titleLRExtraWd}}
        {\bfseries \zihao{3} \songti 中文题目} & \titleBox{#1} \\
                                                        &      \\[-20pt]
        {\bfseries \zihao{3} \songti 英文题目} & \titleBox{#2}
    \end{tabular}
}

\newcommand{\makecover}{
    \pagestyle{style@empty}
    \begin{titlepage}
        \newcommand{\HRule}{\rule{\linewidth}{1mm}}

        % 使用新版标题页
        % \quad \\[0cm]
        % {\centering\includegraphics[width = 1\textwidth]{figures/__logo.png}\\[0.7cm] }
        % \center
        
        % 使用旧版标题页
        \quad \\[0.42cm]
        {\centering\includegraphics[width = 0.8\textwidth]{figures/__logo_old.png}\\[0.77cm] }
        \center
        
        {\songti \zihao{-0} \bfseries 本科生毕业论文（设计）}   \\[1.55cm]
        
        \multilingualTitles
        {\bfseries \fontsize{16pt}{16pt} \songti \cover@ctitle}
        {\bfseries \cover@etitle }

        \vspace{3cm}
        \setstretch{1.5} 
        \songti \zihao{3} \bfseries 学生姓名         \underline{\makebox[2.4cm]{\cover@author}}
        \songti \zihao{3} \bfseries 班级             \underline{\makebox[2.3cm]{\cover@studentclass}}
        \songti \zihao{3} \bfseries 学号             \underline{\makebox[2.5cm]{\cover@studentid}}  
        \\[3pt]
        \songti \zihao{3} \bfseries 学\hspace{2em}院 \underline{\makebox[10cm]{\cover@school}}
        \\[3pt]
        \songti \zihao{3} \bfseries 专\hspace{2em}业 \underline{\makebox[10cm]{\cover@major}}
        \\[3pt]
        \songti \zihao{3} \bfseries 指导教师         \underline{\makebox[4.25cm]{\cover@mentor}}
        \songti \zihao{3} \bfseries 职称 \underline{\makebox[4.25cm]{\cover@proftitle}}
        \\[2.5cm]
        
        {\songti \zihao{3} \bfseries \cover@time}
        \vfill 
    \end{titlepage}
}

\newcommand{\coverstyle}{
    \pagestyle{style@empty}
    \ctexset {chapter = {pagestyle = style@empty}}
}

\newcommand{\headerstyle}{
    \pagenumbering{Roman}
    \setcounter{page}{1}
    \pagestyle{style@preliminary_black}
    \ctexset {chapter = {pagestyle = style@preliminary_black}}
}

\newcommand{\contentstyle}{
    \pagenumbering{arabic} 
    \setcounter{page}{1}
    \pagestyle{style@normal}
    \ctexset {chapter = {pagestyle = style@normal}}
    \zihao{-4}
}

%-------------------------------------------------------------------------------
%                版权授权书
%-------------------------------------------------------------------------------
\newcommand{\cla}{

    \setlength{\baselineskip}{30pt}
    \chapter*{\zihao{-2} \songti \cla@title}
    % \addcontentsline{toc}{chapter}{\cla@title}
    \vspace{1.5cm}

    {\zihao{4} \songti \cla@content} \\[-0.4cm]

    % 保密选择
    \zihao{4} \songti \hspace{6em} \textbf{保密}\ifthenelse{\equal{\cla@select}{1}}{\CheckedBox，在\underline{\hspace{1em} \cla@expire \hspace{1em}}年解密后适用本授权书。}{\Square，在\underline{\hspace{2.5em}}年解密后适用本授权书。} \\[-1.2cm]

    \zihao{4} \songti 本论文属于 \\[-1.2cm]

    \zihao{4} \songti \hspace{6em} \textbf{不保密}\ifthenelse{\equal{\cla@select}{0}}{\CheckedBox。}{\Square。} \\[-1cm]

    \zihao{4} \songti （请在以上方框内打“√”） \\[1cm]
    
    \ifx\cla@signhint\empty
    \else
        \noindent {\zihao{4} \songti \cla@signhint \cla@signimage} \hfill
    \fi
    \ifx\cla@signhintmentor\empty
    \else
        {\zihao{4} \songti \cla@signhintmentor \cla@signimagementor \hspace{2cm}}
    \fi
    \\[1cm]
    \noindent {\zihao{4} \songti 日期：\cla@time}\hfill{\zihao{4} \songti 日期：\cla@timementor \hspace{2cm}}

    \vfill
}


%-------------------------------------------------------------------------------
%                承诺书
%-------------------------------------------------------------------------------
\newcommand{\commitment}{
    
    \setlength{\baselineskip}{30pt}

    \chapter*{\zihao{-2} \songti \commitment@title}
    % \addcontentsline{toc}{chapter}{\commitment@title}
    \vspace{1.5cm}

    \ifx\commitment@content\empty
    \else
        \zihao{4} \songti \commitment@content \\[5cm]
    \fi

    \ifx\commitment@signhint\empty
    \else
        \leftline{\zihao{4} \songti \hspace{4cm} \commitment@signhint \commitment@signimage}
    \fi
    \ifx\commitment@time\empty
    \else
        \rightline{\zihao{4} \songti \commitment@time \hspace{2cm}}
    \fi
    \vfill
}


%-------------------------------------------------------------------------------
%                摘要
%-------------------------------------------------------------------------------

\newcommand{\basabstracten}[4]{
    \setlength{\baselineskip}{20pt}
    \vspace{1em}
    \chapter*{\normalfont \zihao{3} \songti #1}
    \hfill \zihao{4} \songti Author: \cover@authoren \par
    \hfill \zihao{4} \songti Supervisor: \cover@mentoren
    \vspace{1em}

    \begin{center}
    \zihao{4} \songti \bfseries #2
    \end{center}

    \vspace{0.2em}
    \zihao{-4} \songti #3
    \vspace{0.2em}
    \begin{flushleft}
        \zihao{4} \songti {\bfseries {#4}}
    \end{flushleft}
    
}

\newcommand{\basabstractsc}[4]{
    \setlength{\baselineskip}{20pt}
    \vspace{1em}
    \chapter*{\normalfont \zihao{3} \songti #1}
    \vspace{1em}

    \begin{center}
    \zihao{4} \songti \bfseries #2
    \end{center}

    \vspace{0.2em}
    \zihao{-4} \songti #3
    \vspace{1em}
    \begin{flushleft}
        \zihao{4} \songti {\bfseries {#4}}
    \end{flushleft}
    
}

% 中文摘要
\newcommand{\abstractsc}[2]{
    \basabstractsc{\cover@ctitle}{\abstract@abstractsc}{#1}{\abstract@ckeywords} % 摘要标题 / 摘要内容 / 关键词标题 / 关键词内容 
    \hspace{0.5em} #2
    \vfill
    \newpage
}

% 英文摘要
\newcommand{\abstracten}[2]{
    \basabstracten{\cover@etitle}{\abstract@abstracten}{#1}{\abstract@ekeywords}
    \hspace{0.5em} #2
    \vfill
    \newpage
}



%-------------------------------------------------------------------------------
%           目录     
%-------------------------------------------------------------------------------

\renewcommand{\contentsname}{\zihao{3} \songti \bfseries 目\hspace{1em}录}
\renewcommand{\cfttoctitlefont}{\hfill\Large\bfseries}      % title 前间隔
\renewcommand{\cftaftertoctitle}{\hfill}

\renewcommand\cftchapfont{\heiti \bfseries \zihao{-4}}
\renewcommand\cftsecfont{\songti \zihao{-4}}
\renewcommand\cftsubsecfont{\songti \zihao{-4}}
\renewcommand\cftsubsubsecfont{\songti \zihao{-4}}

\renewcommand{\cftaftertoctitle}{\hfill}                    % title 后间隔
\renewcommand{\cftchappagefont}{}                           % 设置索引不加粗

\renewcommand{\cftsecleader}{\cftdotfill{1.5}}              % 目录后一行连续的点
\renewcommand{\cftchapleader}{\cftdotfill{1.5}}             % 目录后一行连续的点
\renewcommand{\cftsubsecleader}{\cftdotfill{1.5}}           % 目录后一行连续的点
\setlength{\cftbeforetoctitleskip}{0pt}                     % title 上间隔
\setlength{\cftaftertoctitleskip}{30pt}                      % title 下间隔
\setlength{\cftbeforechapskip}{5pt}                         % chapter 间隔
\setlength{\cftbeforesecskip}{5pt}                          % section 间隔
\setlength{\cftbeforesubsecskip}{5pt}                       % subsection 间隔
\setlength{\cftbeforesubsubsecskip}{5pt}                    % subsubsection 间隔
\setlength{\cftchapindent}{0pt}                             % 设置 chapter 部分缩进
\setlength{\cftsecindent}{20pt}	                            % 设置 section 部分缩进
\setlength{\cftsubsecindent}{40pt}                          % 设置 subsection 缩进
\setlength{\cftsubsubsecindent}{60pt}                       % 设置 subsubsection 缩进
\settowidth{\cftchapnumwidth}{\cftsecfont 1.2}              % 设置 chapter 内容部分缩进
\settowidth{\cftsecnumwidth}{\cftsecfont 1.2}               % 设置 section 内容部分缩进
\settowidth{\cftsubsecnumwidth}{\cftsecfont 1.2}            % 设置 subsection 内容部分缩进
\settowidth{\cftsubsubsecnumwidth}{\cftsecfont 1.2}         % 设置 subsubsection 内容部分缩进

%-------------------------------------------------------------------------------
%                章节标题格式
%-------------------------------------------------------------------------------
\ctexset {
    chapter = {
        format = \centering \zihao{-3} \songti \bfseries,
        titleformat = \hspace{-12pt}\hspace{1em},
        beforeskip = {-21pt},
        afterskip = {11pt},
        number = \arabic{chapter},
        pagestyle = style@normal
    },
    section = {
        format = \raggedright \zihao{4} \songti \bfseries,
        titleformat = \hspace{-12pt}\hspace{1em},
        beforeskip = {0pt},
        afterskip = {3pt},
    },
    subsection = {
        format = \raggedright \zihao{4} \songti \bfseries,
        titleformat = \hspace{-12pt}\hspace{1em},
        beforeskip = {0pt},
        afterskip = {3pt},
    },
    subsubsection = {
        format = \raggedright \zihao{4} \songti,
        titleformat = \hspace{-12pt}\hspace{1em},
        beforeskip = {0pt},
        afterskip = {3pt},
    }
}

% 图片 --- 图片路径，图片标题，图片引用名
\newcommand{\insertfig}[3]{
    \begin{figure}[htb] %H为当前位置，!htb为忽略美学标准，htbp为浮动图形
        % 图片与上下文的间距
        \setlength{\intextsep}{10pt}
        \setlength{\belowcaptionskip}{0cm} %调整图片标题与下文距离
        \centering %图片居中
        \includegraphics[width=0.9\textwidth]{#1} %插入图片，[]中设置图片大小，{}中是图片文件名
        \caption{#2} % 最终文档中希望显示的图片标题
        \label{#3} % 用于文内引用的标签
    \end{figure}
}

% TeX Figure --- 图片TeX文件路径，图片标题，图片引用名
\newcommand{\inserttexfig}[3]{
    \begin{figure}[htb] %H为当前位置，!htb为忽略美学标准，htbp为浮动图形
        % 图片与上下文的间距
        \setlength{\intextsep}{10pt}
        \setlength{\belowcaptionskip}{0cm} %调整图片标题与下文距离
        \centering %图片居中
        \input{#1} %插入图片，[]中设置图片大小，{}中是图片文件名
        \caption{#2} % 最终文档中希望显示的图片标题
        \label{#3} % 用于文内引用的标签
    \end{figure}
}

%-------------------------------------------------------------------------------
%                参考文献 格式
%-------------------------------------------------------------------------------

\setlength{\bibsep}{0.3\baselineskip}
\renewcommand{\bibfont}{\fontsize{10pt}{12pt}\selectfont} 


%-------------------------------------------------------------------------------
%                致谢
%-------------------------------------------------------------------------------
\newcommand{\Acknowledgements}[1]{
    \setlength{\baselineskip}{20pt}
    \chapter*{\zihao{-3} \songti 致\hspace{1em}谢}
    \addcontentsline{toc}{chapter}{致\hspace{1em}谢}
    \markboth{\zihao{-5} \songti 致\hspace{1em}谢}{\zihao{-5} \songti 致\hspace{1em}谢} % 定制页眉
    \vspace{0.5cm}
    {\songti \zihao{-4} #1}
}

%-------------------------------------------------------------------------------
%                自定义命令
%-------------------------------------------------------------------------------
\newcommand{\code}[1]{
    \texttt{#1}
}

\newcommand{\highlight}[1]{
    \textcolor{red}{#1}
}

\newcommand{\bold}[1]{
    \textbf{#1}
}

\newcommand{\italic}[1]{
    \textit{#1}
}

\endinput
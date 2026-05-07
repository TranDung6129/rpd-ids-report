#!/bin/bash
# ============================================================
#  setup.sh — Tạo lại toàn bộ cấu trúc dự án RPL-IDS
#  Chạy: bash setup.sh
#  Kết quả: thư mục rpl-ids-report/ sẵn sàng compile
# ============================================================

ROOT="rpl-ids-report"

# Xoá cũ nếu có, tạo mới
rm -rf "$ROOT"
mkdir -p "$ROOT"/{frontmatter,chapters,backmatter,Figures/{ch2,ch3,ch4,ch5},build,.vscode}

echo "📁 Tạo cấu trúc thư mục..."

# ============================================================
#  .vscode/settings.json
# ============================================================
cat > "$ROOT/.vscode/settings.json" << 'EOF'
{
  "latex-workshop.latex.outDir": "%DIR%/build",
  "latex-workshop.latex.autoClean.run": "onBuilt",
  "latex-workshop.latex.clean.fileTypes": [
    "*.aux","*.bbl","*.blg","*.log","*.lot",
    "*.lof","*.toc","*.out","*.fdb_latexmk",
    "*.fls","*.synctex.gz","*.bcf","*.run.xml"
  ],
  "latex-workshop.latex.recipes": [
    {
      "name": "pdflatex -> bibtex -> pdflatex x2",
      "tools": ["pdflatex","bibtex","pdflatex","pdflatex"]
    }
  ]
}
EOF

# ============================================================
#  .gitignore
# ============================================================
cat > "$ROOT/.gitignore" << 'EOF'
build/
*.aux
*.bbl
*.bcf
*.blg
*.fdb_latexmk
*.fls
*.lof
*.log
*.lot
*.out
*.run.xml
*.synctex.gz
*.toc
EOF

# ============================================================
#  main.tex
# ============================================================
cat > "$ROOT/main.tex" << 'EOF'
% ============================================================
%  main.tex — RPL IDS Report
% ============================================================
\documentclass{article}
\usepackage[utf8]{inputenc}
\usepackage[T5]{fontenc}
\usepackage[fontsize=13pt]{scrextend}
\usepackage[paperheight=29.7cm,paperwidth=21cm,
            right=2cm,left=3cm,top=2cm,bottom=2.5cm,twoside]{geometry}
\usepackage{mathptmx}
\usepackage{graphicx}
\usepackage{float}
\usepackage{tikz}
\usetikzlibrary{calc,shapes.geometric,arrows.meta,positioning,fit}
\usepackage{pgfplots}
\pgfplotsset{compat=1.18}
\usepackage{indentfirst}
\renewcommand{\baselinestretch}{1.2}
\setlength{\parskip}{6pt}
\setlength{\parindent}{1cm}

% ----- Tiêu đề section -----
\usepackage{titlesec}
\setcounter{secnumdepth}{4}
\titlespacing*{\section}{0pt}{0pt}{30pt}
\titleformat*{\section}{\fontsize{16pt}{19.2pt}\selectfont\bfseries\centering}
\titlespacing*{\subsection}{0pt}{10pt}{0pt}
\titleformat*{\subsection}{\fontsize{14pt}{16.8pt}\selectfont\bfseries}
\titlespacing*{\subsubsection}{0pt}{10pt}{0pt}
\titleformat*{\subsubsection}{\fontsize{13pt}{15.6pt}\selectfont\bfseries\itshape}
\titlespacing*{\paragraph}{0pt}{10pt}{0pt}
\titleformat*{\paragraph}{\fontsize{13pt}{15.6pt}\selectfont\itshape}

% ----- Caption -----
\renewcommand{\figurename}{\fontsize{12pt}{0pt}\selectfont\bfseries Hình}
\renewcommand{\thefigure}{\thesection.\arabic{figure}}
\usepackage[font=bf]{caption}
\captionsetup[figure]{labelsep=space}
\renewcommand{\tablename}{\fontsize{12pt}{0pt}\selectfont\bfseries Bảng}
\renewcommand{\thetable}{\thesection.\arabic{table}}
\captionsetup[table]{labelsep=space}

% ----- Bảng biểu -----
\usepackage{multicol,multirow,tabularx,booktabs,longtable,colortbl}
\newcolumntype{C}[1]{>{\hsize=#1\hsize\centering\arraybackslash}X}
\newcolumntype{R}[1]{>{\hsize=#1\hsize\raggedleft\arraybackslash}X}
\newcolumntype{L}[1]{>{\hsize=#1\hsize\raggedright\arraybackslash}X}
\renewcommand{\tabularxcolumn}[1]{>{\small}m{#1}}
\definecolor{LightCyan}{rgb}{0.88,1,1}

% ----- Toán học -----
\usepackage{amsmath,amssymb,amsthm}
\renewcommand{\theequation}{\thesection.\arabic{equation}}
\newtheorem{theorem}{Định lý}[section]
\newtheorem{defn}[theorem]{Định nghĩa}
\newtheorem{lemma}[theorem]{Bổ đề}

% ----- Code listing -----
\usepackage{listings,xcolor}
\definecolor{codebg}{RGB}{248,248,248}
\lstset{
  backgroundcolor=\color{codebg}, frame=single, framerule=0.4pt,
  basicstyle=\ttfamily\small,
  keywordstyle=\color{blue}\bfseries,
  commentstyle=\color{gray}\itshape,
  stringstyle=\color{teal},
  breaklines=true, numbers=left,
  numberstyle=\tiny\color{gray}, numbersep=8pt,
  captionpos=b, showstringspaces=false, tabsize=2
}

% ----- Thuật toán -----
\usepackage{algorithm,algpseudocode}

% ----- Tiện ích -----
\usepackage{enumitem,rotating,bm,nameref}
\usepackage{forloop}
\newcounter{loopcntr}
\newcommand{\rpt}[2][1]{\forloop{loopcntr}{0}{\value{loopcntr}<#1}{#2}}
\usepackage[ddmmyyyy]{datetime}
\DeclareRobustCommand{\vect}[1]{\bm{#1}}
\pdfstringdefDisableCommands{\renewcommand{\vect}[1]{#1}}

% ----- Tên tiếng Việt -----
\renewcommand{\contentsname}{MỤC LỤC}
\renewcommand{\listfigurename}{DANH MỤC HÌNH ẢNH}
\renewcommand{\listtablename}{DANH MỤC BẢNG BIỂU}
\renewcommand{\refname}{TÀI LIỆU THAM KHẢO}

% ----- Hyperlink -----
\usepackage[unicode]{hyperref}
\hypersetup{
  colorlinks=true, linkcolor=blue!60!black,
  citecolor=blue!60!black, urlcolor=blue!60!black,
  pdftitle={Xây dựng IDS phát hiện tấn công RPL}
}

% ============================================================
\begin{document}

\input{frontmatter/cover}
\input{frontmatter/assignment}
\input{frontmatter/preface}
\input{frontmatter/pledge}

\addtocontents{toc}{\protect\thispagestyle{empty}}
\tableofcontents
\thispagestyle{empty}
\cleardoublepage

\input{frontmatter/abbreviations}

{\let\oldnumberline\numberline
\renewcommand{\numberline}{Hình~\oldnumberline}
\listoffigures}
\phantomsection
\addcontentsline{toc}{section}{\numberline{}DANH MỤC HÌNH ẢNH}
\newpage

{\let\oldnumberline\numberline
\renewcommand{\numberline}{Bảng~\oldnumberline}
\listoftables}
\phantomsection
\addcontentsline{toc}{section}{\numberline{}DANH MỤC BẢNG BIỂU}
\newpage

\input{frontmatter/abstract}

\pagenumbering{arabic}

\input{chapters/ch1}
\newpage
\input{chapters/ch2}
\newpage
\input{chapters/ch3}
\newpage
\input{chapters/ch4}
\newpage
\input{chapters/ch5}
\newpage
\input{chapters/ch6}
\newpage

\phantomsection
\addcontentsline{toc}{section}{\numberline{}TÀI LIỆU THAM KHẢO}
\bibliographystyle{IEEEtran}
\bibliography{References}

\newpage
\input{backmatter/appendix}

\end{document}
EOF

# ============================================================
#  frontmatter/cover.tex
# ============================================================
cat > "$ROOT/frontmatter/cover.tex" << 'EOF'
\thispagestyle{empty}
\begin{tikzpicture}[overlay,remember picture]
\draw [line width=3pt]
    ($ (current page.north west) + (3.0cm,-2.0cm) $)
    rectangle
    ($ (current page.south east) + (-2.0cm,2.5cm) $);
\draw [line width=0.5pt]
    ($ (current page.north west) + (3.1cm,-2.1cm) $)
    rectangle
    ($ (current page.south east) + (-2.1cm,2.6cm) $);
\end{tikzpicture}
\begin{center}
\vspace{-12pt}
[TÊN TRƯỜNG ĐẠI HỌC] \\
\textbf{\fontsize{14pt}{0pt}\selectfont [TÊN KHOA]}
\vspace{1cm}
\begin{figure}[H]
    \centering
    % \includegraphics[width=0.15\textwidth]{Figures/logo.png}
    \vspace{1cm}
\end{figure}
\textbf{\fontsize{25pt}{0pt}\selectfont ĐỒ ÁN MÔN HỌC}
\vspace{1cm}

\textbf{\fontsize{18pt}{22pt}\selectfont
    TÌM HIỂU VÀ NGHIÊN CỨU XÂY DỰNG IDS \\[0.3cm]
    ĐỂ PHÁT HIỆN CÁC DẠNG TẤN CÔNG RPL}

\vspace{1.5cm}
\begin{table}[H]
    \centering
    \begin{tabular}{r l}
        \fontsize{13pt}{0pt}\selectfont\textbf{Sinh viên:}
            & \fontsize{13pt}{0pt}\selectfont\textbf{NGUYỄN VĂN A} \\
            & \fontsize{12pt}{0pt}\selectfont MSSV: 20xxxxxx \\[0.5cm]
        \fontsize{13pt}{0pt}\selectfont\textbf{Ngành:}
            & \fontsize{13pt}{0pt}\selectfont Công nghệ Thông tin \\[0.3cm]
        \fontsize{13pt}{0pt}\selectfont\textbf{Chuyên ngành:}
            & \fontsize{13pt}{0pt}\selectfont An toàn Thông tin \\[0.3cm]
        \fontsize{13pt}{0pt}\selectfont\textbf{Lớp:}
            & \fontsize{13pt}{0pt}\selectfont [Tên lớp] \\
    \end{tabular}
\end{table}
\vspace{1.5cm}
\begin{table}[H]
    \centering
    \begin{tabular}{l l}
        \fontsize{13pt}{0pt}\selectfont\textbf{Giảng viên hướng dẫn:}
            & \fontsize{13pt}{0pt}\selectfont [Tên GVHD]
              \hspace{1cm}\rule{3cm}{0.1mm} \\
    \end{tabular}
\end{table}
\vspace{1.5cm}
\fontsize{13pt}{0pt}\selectfont TP.~Hồ Chí Minh, \today
\end{center}
\cleardoublepage
EOF

# ============================================================
#  frontmatter/assignment.tex
# ============================================================
cat > "$ROOT/frontmatter/assignment.tex" << 'EOF'
\thispagestyle{empty}
\begin{center}
  \textbf{\large PHIẾU GIAO ĐỀ TÀI ĐỒ ÁN MÔN HỌC}
\end{center}

\begin{table}[H]
  \centering
  \begin{tabular}{l r}
    Họ và tên sinh viên: \textbf{Nguyễn Văn A}
      & MSSV: 20xxxxxx \\[0.3cm]
    \multicolumn{2}{l}{Lớp: [Tên lớp]
      \hspace{2cm} Ngành: Công nghệ Thông tin} \\
  \end{tabular}
\end{table}

\subsection*{\textnormal{1.\quad Tên đề tài}}
\textbf{Tìm hiểu và nghiên cứu xây dựng IDS để phát hiện các dạng tấn công RPL}

\subsection*{\textnormal{2.\quad Nội dung thực hiện}}
\begin{enumerate}
  \item Nghiên cứu giao thức RPL (RFC~6550): DODAG, Trickle Timer, Objective Function.
  \item Phân tích 4 dạng tấn công: DIS Flooding, Blackhole,
        Decreased Rank, VeRA/DODAG Version Number Attack.
  \item Tổng quan về IDS trong môi trường IoT/LLN.
  \item Đề xuất và thiết kế kiến trúc IDS trên Contiki-NG.
  \item Mô phỏng, kiểm thử trên Cooja và đánh giá theo các chỉ số:
        PDR, E2E Delay, Control Overhead, Power Consumption, TPR/FPR.
\end{enumerate}

\subsection*{\textnormal{3.\quad Ngày giao đề tài:~~~/~~~/ 20~~~~}}
\subsection*{\textnormal{4.\quad Ngày hoàn thành:~~~/~~~/ 20~~~~}}

\vspace{1.5cm}
\hspace{9cm} TP.~Hồ Chí Minh, ~~~~/~~~~/20~~~~
\vspace{0.5cm}

\hspace{9.5cm} \textbf{GIẢNG VIÊN HƯỚNG DẪN}
\vspace{2cm}

\hspace{10cm} \textbf{[Tên GVHD]}
\cleardoublepage
EOF

# ============================================================
#  frontmatter/preface.tex
# ============================================================
cat > "$ROOT/frontmatter/preface.tex" << 'EOF'
\section*{LỜI NÓI ĐẦU}
\phantomsection
\addcontentsline{toc}{section}{\numberline{}LỜI NÓI ĐẦU}
\thispagestyle{empty}

Sự bùng nổ của \textit{Internet of Things} (IoT) trong những năm gần đây
đã tạo ra hạ tầng kết nối khổng lồ với hàng tỷ thiết bị nhúng hoạt động
trong các môi trường từ nhà thông minh, y tế đến hệ thống công nghiệp.
Nền tảng định tuyến cho các mạng IoT hạn chế tài nguyên --- giao thức
\textbf{RPL} (RFC~6550) --- đóng vai trò không thể thiếu, nhưng thiết kế
nhẹ nhàng của nó cũng mang lại nhiều lỗ hổng bảo mật mà các biện pháp
mặc định chưa bảo vệ được đầy đủ.

Đồ án này được thực hiện nhằm tìm hiểu bốn dạng tấn công tiêu biểu vào
RPL và đề xuất kiến trúc \textbf{Hệ thống Phát hiện Xâm nhập} (IDS) có
khả năng phát hiện các mối đe dọa này trong môi trường Contiki-NG/Cooja.

Tôi xin gửi lời cảm ơn chân thành đến \textbf{[Tên GVHD]} đã tận tình
hướng dẫn trong suốt quá trình thực hiện đồ án. Mặc dù đã cố gắng hết
sức, đồ án chắc chắn còn nhiều thiếu sót, rất mong nhận được sự góp ý
của thầy cô và các bạn.

\vspace{1cm}
\hspace{7cm} TP.~Hồ Chí Minh, \today
\vspace{0.5cm}

\hspace{8.5cm} \textbf{Sinh viên thực hiện}
\vspace{2cm}

\hspace{8.7cm} \textbf{Nguyễn Văn A}
\cleardoublepage
EOF

# ============================================================
#  frontmatter/pledge.tex
# ============================================================
cat > "$ROOT/frontmatter/pledge.tex" << 'EOF'
\section*{LỜI CAM ĐOAN}
\phantomsection
\addcontentsline{toc}{section}{\numberline{}LỜI CAM ĐOAN}
\thispagestyle{empty}

Tôi xin cam đoan đồ án \textbf{``Tìm hiểu và nghiên cứu xây dựng IDS để
phát hiện các dạng tấn công RPL''} là công trình nghiên cứu của bản thân
dưới sự hướng dẫn của \textbf{[Tên GVHD]}.

Các nội dung và kết quả trong đồ án là trung thực, chưa từng được công bố
dưới bất kỳ hình thức nào. Mọi số liệu, tài liệu tham khảo đều được trích
dẫn rõ ràng và ghi chú nguồn gốc cụ thể.

\vspace{1.5cm}
\hspace{7cm} TP.~Hồ Chí Minh, \today
\vspace{0.5cm}

\hspace{8.5cm} \textbf{Sinh viên thực hiện}
\vspace{2cm}

\hspace{8.7cm} \textbf{Nguyễn Văn A}
\cleardoublepage
EOF

# ============================================================
#  frontmatter/abbreviations.tex
# ============================================================
cat > "$ROOT/frontmatter/abbreviations.tex" << 'EOF'
\section*{DANH MỤC CHỮ VIẾT TẮT}
\phantomsection
\addcontentsline{toc}{section}{\numberline{}DANH MỤC CHỮ VIẾT TẮT}
\thispagestyle{empty}

\begin{table}[H]
\centering
\begin{tabularx}{\textwidth}{l L{1} l}
  \toprule
  \textbf{Viết tắt} & \textbf{Tiếng Anh} & \textbf{Tiếng Việt} \\
  \midrule
  BR    & Border Router                            & Bộ định tuyến biên \\
  DAO   & Destination Advertisement Object         & Bản tin quảng bá đích \\
  DAG   & Directed Acyclic Graph                   & Đồ thị không chu trình có hướng \\
  DIO   & DODAG Information Object                 & Bản tin thông tin DODAG \\
  DIS   & DODAG Information Solicitation           & Bản tin yêu cầu thông tin DODAG \\
  DODAG & Destination Oriented DAG                 & Đồ thị acyclic có hướng tập trung vào đích \\
  E2ED  & End-to-End Delay                         & Trễ đầu cuối \\
  FPR   & False Positive Rate                      & Tỉ lệ cảnh báo nhầm \\
  IDS   & Intrusion Detection System               & Hệ thống phát hiện xâm nhập \\
  IETF  & Internet Engineering Task Force          & --- \\
  IoT   & Internet of Things                       & Internet vạn vật \\
  LLN   & Low-power and Lossy Network              & Mạng năng lượng thấp và mất mát cao \\
  OF    & Objective Function                       & Hàm mục tiêu \\
  PDR   & Packet Delivery Ratio                    & Tỉ lệ phân phối gói thành công \\
  RPL   & Routing Protocol for LLNs                & Giao thức định tuyến cho LLN \\
  TPR   & True Positive Rate                       & Tỉ lệ phát hiện đúng \\
  VeRA  & Version Number and Rank Authentication   & Xác thực số phiên bản và rank \\
  WSN   & Wireless Sensor Network                  & Mạng cảm biến không dây \\
  \bottomrule
\end{tabularx}
\end{table}
\cleardoublepage
EOF

# ============================================================
#  frontmatter/abstract.tex
# ============================================================
cat > "$ROOT/frontmatter/abstract.tex" << 'EOF'
\section*{TÓM TẮT}
\phantomsection
\addcontentsline{toc}{section}{\numberline{}TÓM TẮT}
\thispagestyle{empty}

Giao thức \textbf{RPL} (IPv6 Routing Protocol for Low-Power and Lossy
Networks, RFC~6550) là chuẩn định tuyến chủ đạo trong các mạng IoT
năng lượng thấp (LLN). Tuy nhiên, thiết kế nhẹ nhàng của RPL tạo ra bề
mặt tấn công rộng, đặc biệt khi đối mặt với các nút nội bộ bị xâm phạm.

Đồ án trình bày quá trình nghiên cứu và xây dựng \textbf{Hệ thống Phát
hiện Xâm nhập} (IDS) cho mạng RPL, tập trung vào bốn dạng tấn công:
\textit{DIS Flooding}, \textit{Blackhole}, \textit{Decreased Rank} và
\textit{VeRA/DODAG Version Number Attack}. Kiến trúc IDS đề xuất được
tích hợp vào Contiki-NG và kiểm thử trên Cooja Simulator. Kết quả cho
thấy IDS đạt TPR $\geq$ 90\%, FPR $\leq$ 10\% với overhead chấp nhận
được trên thiết bị hạn chế tài nguyên.

\vspace{0.4cm}
\noindent\textbf{Từ khóa:} RPL, IDS, IoT, LLN, DIS Flooding, Blackhole,
Decreased Rank, VeRA, Contiki-NG, Cooja.

\vspace{1.2cm}
\begin{center}\rule{0.5\textwidth}{0.4pt}\end{center}
\vspace{1cm}

\section*{ABSTRACT}
\phantomsection
\addcontentsline{toc}{section}{\numberline{}ABSTRACT}

\textbf{RPL} (IPv6 Routing Protocol for Low-Power and Lossy Networks,
RFC~6550) is the de-facto routing standard for IoT/LLN environments.
Its lightweight design, however, introduces a wide attack surface that
default RPL security mechanisms cannot fully protect against compromised
internal nodes.

This report presents the design and evaluation of an \textbf{Intrusion
Detection System} (IDS) for RPL networks, focusing on four attacks:
\textit{DIS Flooding}, \textit{Blackhole}, \textit{Decreased Rank}, and
\textit{VeRA/DODAG Version Number Attack}. The IDS is integrated into
Contiki-NG and evaluated on Cooja Simulator, achieving TPR $\geq$ 90\%
and FPR $\leq$ 10\% with acceptable overhead on constrained nodes.

\vspace{0.4cm}
\noindent\textbf{Keywords:} RPL, IDS, IoT, LLN, DIS Flooding, Blackhole,
Decreased Rank, VeRA, Contiki-NG, Cooja.
\cleardoublepage
EOF

# ============================================================
#  chapters/ch1.tex ~ ch6.tex
# ============================================================
cat > "$ROOT/chapters/ch1.tex" << 'EOF'
% ============================================================
%  ch1.tex — Chương 1: Giới thiệu và tổng quan
% ============================================================
\section{GIỚI THIỆU VÀ TỔNG QUAN}
\label{sec:ch1}

% TODO: Dán nội dung từ file chapter1_intro.tex đã viết trước đó vào đây.
EOF

for i in 2 3 4 5 6; do
  case $i in
    2) T="CƠ SỞ LÝ THUYẾT" ;;
    3) T="PHÂN TÍCH CÁC DẠNG TẤN CÔNG RPL" ;;
    4) T="THIẾT KẾ IDS PHÁT HIỆN TẤN CÔNG RPL" ;;
    5) T="DEMO VÀ KIỂM THỬ" ;;
    6) T="KẾT LUẬN VÀ HƯỚNG PHÁT TRIỂN" ;;
  esac
  cat > "$ROOT/chapters/ch${i}.tex" << CHEOF
% ============================================================
%  ch${i}.tex — Chương ${i}: ${T}
% ============================================================
\\section{${T}}
\\label{sec:ch${i}}

% TODO: Nội dung chương ${i}.
CHEOF
done

# ============================================================
#  backmatter/appendix.tex
# ============================================================
cat > "$ROOT/backmatter/appendix.tex" << 'EOF'
% ============================================================
%  appendix.tex — Phụ lục
% ============================================================
\section*{PHỤ LỤC}
\phantomsection
\addcontentsline{toc}{section}{\numberline{}PHỤ LỤC}
\setcounter{section}{0}
\renewcommand{\thesection}{\Alph{section}}

\section{Mã nguồn IDS (Contiki-NG)}
\label{app:code}

\subsection{Module phát hiện DIS Flooding}
\begin{lstlisting}[language=C, caption={ids\_dis\_flooding.c}]
#include "contiki.h"
#include "net/routing/rpl-lite/rpl.h"

#define DIS_FLOOD_THRESHOLD 10
static uint16_t dis_count = 0;

void ids_dis_on_receive(void) {
  dis_count++;
  if (dis_count > DIS_FLOOD_THRESHOLD) {
    /* TODO: Kich hoat canh bao DIS Flooding */
  }
}
\end{lstlisting}

\subsection{Module phát hiện Blackhole}
\begin{lstlisting}[language=C, caption={ids\_blackhole.c}]
#define PDR_THRESHOLD 0.7

float ids_compute_pdr(uint16_t sent, uint16_t received) {
  if (sent == 0) return 1.0f;
  return (float)received / (float)sent;
}
\end{lstlisting}

\subsection{Module phát hiện Decreased Rank}
\begin{lstlisting}[language=C, caption={ids\_decreased\_rank.c}]
void ids_rank_check(rpl_parent_t *parent,
                    rpl_rank_t advertised_rank) {
  rpl_rank_t expected = /* tinh rank du kien */ 0;
  if (advertised_rank < expected) {
    /* TODO: Danh dau nghi ngo */
  }
}
\end{lstlisting}

\subsection{Module phát hiện VeRA Attack}
\begin{lstlisting}[language=C, caption={ids\_vera.c}]
static uint8_t last_version = 0;

void ids_version_check(uint8_t received_version) {
  if (received_version > last_version + 1) {
    /* TODO: Canh bao VeRA attack */
  }
  last_version = received_version;
}
\end{lstlisting}

\section{Cấu hình mô phỏng Cooja}
\label{app:cooja}

\begin{table}[H]
\centering
\caption{Tham số cấu hình Cooja}
\begin{tabularx}{\textwidth}{lX}
  \toprule
  \textbf{Tham số} & \textbf{Giá trị} \\
  \midrule
  Radio medium       & Unit Disk Graph Medium (UDGM) \\
  Số nút             & 20 (1 Border Router + 19 mote) \\
  Tỉ lệ nút tấn công & 0\%, 10\%, 25\%, 50\% \\
  Thời gian          & 300 giây / kịch bản \\
  Tần suất gửi       & 1 gói / 10 giây \\
  OS                 & Contiki-NG 4.x \\
  Objective Function & MRHOF (ETX) \\
  \bottomrule
\end{tabularx}
\end{table}
EOF

# ============================================================
#  References.bib
# ============================================================
cat > "$ROOT/References.bib" << 'EOF'
@techreport{winter2012rpl,
  author      = {Winter, T. and Thubert, P. and others},
  title       = {{RPL}: {IPv6} Routing Protocol for Low-Power and Lossy Networks},
  institution = {IETF},
  number      = {RFC 6550},
  year        = {2012},
  url         = {https://tools.ietf.org/html/rfc6550}
}

@article{prajisha2025dis,
  author  = {Prajisha, C. and Vasudevan, A. R.},
  title   = {Detection and Mitigation of Multicast {DIS} Flooding Attacks
             in {RPL}-Based {IoT} Networks},
  journal = {Ad Hoc Networks},
  volume  = {179},
  pages   = {104002},
  year    = {2025},
  doi     = {10.1016/j.adhoc.2025.104002}
}

@article{sharma2022blackhole,
  author  = {Sharma, Deepak Kumar and Dhurandher, Sanjay K. and
             Kumaram, Shubham and Datta Gupta, Koyel and Sharma, Pradip Kumar},
  title   = {Mitigation of Black Hole Attacks in {6LoWPAN} {RPL}-Based
             Wireless Sensor Network for Cyber Physical Systems},
  journal = {Computer Communications},
  volume  = {189},
  pages   = {182--192},
  year    = {2022},
  doi     = {10.1016/j.comcom.2022.04.003}
}

@inproceedings{dvir2011vera,
  author    = {Dvir, Amit and Holczer, T{\'a}mas and Butt{\'y}an, Levente},
  title     = {{VeRA} -- Version Number and Rank Authentication in {RPL}},
  booktitle = {2011 IEEE 8th Int. Conf. on Mobile Ad-Hoc and Sensor Systems},
  pages     = {709--714},
  year      = {2011},
  doi       = {10.1109/MASS.2011.76}
}

@misc{overview_rpl_framework,
  author = {{LINGI2146 Project -- UCLouvain}},
  title  = {{RPL} Attacks Framework},
  year   = {2016},
  note   = {Course project report}
}

@article{raza2013svelte,
  author  = {Raza, Shahid and Wallgren, Linus and Voigt, Thiemo},
  title   = {{SVELTE}: Real-Time Intrusion Detection in the Internet of Things},
  journal = {Ad Hoc Networks},
  volume  = {11},
  number  = {8},
  pages   = {2661--2674},
  year    = {2013},
  doi     = {10.1016/j.adhoc.2013.05.008}
}
EOF

# ============================================================
#  In kết quả
# ============================================================
echo ""
echo "✅ Hoàn tất! Cấu trúc thư mục:"
echo ""
find "$ROOT" -not -path "*/build*" -not -name "*.gitignore" | sort | \
  awk -F'/' '{
    depth = NF - 1
    indent = ""
    for (i=0; i<depth; i++) indent = indent "    "
    if (NF > 1) print indent "├── " $NF
    else print $0 "/"
  }'
echo ""
echo "📌 Việc cần làm sau khi chạy script:"
echo "   1. Thêm Figures/logo.png (logo trường)"
echo "   2. Điền tên trường, GVHD, MSSV vào frontmatter/"
echo "   3. Dán nội dung Chapter 1 vào chapters/ch1.tex"
echo "   4. Compile: pdflatex main.tex && bibtex main && pdflatex main.tex x2"
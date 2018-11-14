# Font size in LaTeX
| preamble | 10pt | 11pt | 12pt |
|:---|:---|:---|:---|
| \tiny | 5pt | 6pt | 6pt |
| \scriptsize | 7pt | 8pt | 8pt |
| \footnotesize | 8pt | 9pt | 10pt |
| \small | 9pt | 10pt | 11pt |
| \normalsize | 10pt | 11pt | 12pt |
| \large | 12pt | 12pt | 14pt |
| \Large | 14pt | 14pt | 17pt |
| \LARGE | 17pt | 17pt | 20pt |
| \huge | 20pt | 20pt | 25pt |
| \Huge | 25pt | 25pt | 25pt |

# TeX file in Japanese
## Documents
- upLaTeX (recommended)
	- only use utf-8
	- preamble

			\documentclass[12pt,a4paper,dvipdfmx,upLaTeX]{jsarticle}

	- compilation

			platex.sh file-name (w/o extension)


- pLaTeX
	- SJIS can be used
	- preamble

			\documentclass[12pt,a4paper,dvipdfmx]{jsarticle}

	- compilation

			platex.sh file-name (w/o extension)


## Presentations
- Beamer
	- preamble

			\documentclass[dvipdfmx,12pt]{beamer}
			\usepackage{bxdpx-beamer}
			\usepackage{pxjahyper}
			\usepackage{minijs}
			\renewcommand{\kanjifamilydefault}{\gtdefault}

	- compilation

			platex.sh file-name (w/o extension)
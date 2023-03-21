.PHONY: all release clean

common_deps := csustThesis.cls baseinfo.tex reference.bib

all: thesis.pdf research_proposal.pdf task_book.pdf translation.pdf slides/slides.pdf

release: thesis.pdf research_proposal.pdf task_book.pdf translation.pdf slides/slides.pdf
	mkdir -p release
	mv $^ release

thesis.pdf: thesis.tex ${common_deps}
	xelatex thesis
	biber thesis
	xelatex thesis
	xelatex thesis

research_proposal.pdf: research_proposal.tex ${common_deps}
	xelatex research_proposal
	biber research_proposal
	xelatex research_proposal
	xelatex research_proposal

task_book.pdf: task_book.tex ${common_deps}
	xelatex task_book
	biber task_book
	xelatex task_book
	xelatex task_book

translation.pdf: translation.tex ${common_deps}
	xelatex translation
	biber translation
	xelatex translation
	xelatex translation

slides/slides.pdf: slides/slides.tex
	cd slides && xelatex slides && xelatex slides

clean:
	-rm *.aux *.bbl *.bcf *.blg *.lof *.log *.pdf *.run.xml *.toc *.lot
	-cd slides && rm *.aux *.log *.nav *.out *.pdf *.snm *.toc
	-rm -rf release
	-rm body/*.aux

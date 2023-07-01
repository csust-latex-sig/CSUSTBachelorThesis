# use *.* to exclude sub-folders
template_figs := figure/template/*.*
thesis_figs := figure/thesis/*

common_deps := csustThesis.cls baseinfo.tex reference.bib
template_deps := ${template_figs} ${common_deps}
body_deps := body/*.tex

# dependencies for each PDF
thesis_deps := thesis.tex ${template_deps} ${thesis_figs} ${body_deps}
research_proposal_deps := research_proposal.tex ${template_deps}
task_book_deps := task_book.tex ${template_deps}
translation_deps := translation.tex ${template_deps}

# these files can be removed by `make clean`
output_pdfs := thesis.pdf research_proposal.pdf task_book.pdf translation.pdf
tmp_files := *.aux *.bbl *.bcf *.blg *.lof *.log *.run.xml *.toc *.lot *.nav \
						 *.out *.snm *.toc

# Macros
compile_pdf = xelatex "$(1)" && \
								 biber "$(1)" && \
								 xelatex "$(1)" && \
								 xelatex "$(1)"

.PHONY: all
all: ${output_pdfs}

.PHONY: test
test: ${output_pdfs}

.PHONY: release
release: ${output_pdfs}
	mkdir -p release
	mv $^ release

# 论文
.PHONY: thesis
thesis: thesis.pdf

thesis.pdf: ${thesis_deps}
	$(call compile_pdf,thesis)

# 开题报告
.PHONY: research_proposal
research_proposal: research_proposal.pdf

research_proposal.pdf: ${research_proposal_deps}
	$(call compile_pdf,research_proposal)

# 任务书
.PHONY: task_book
task_book: task_book.pdf

task_book.pdf: ${task_book_deps}
	$(call compile_pdf,task_book)

# 译文
.PHONY: translation
translation: translation.pdf

translation.pdf: ${translation_deps}
	$(call compile_pdf,translation)

.PHONY: clean
clean:
	@echo "注意！！！以下生成的 PDF 也会被删除："
	@echo "${output_pdfs}"
	-@rm -f ${tmp_files}
	-@cd body && rm -f ${tmp_files}
	-@rm -rf release/
	-@rm -f ${output_pdfs}

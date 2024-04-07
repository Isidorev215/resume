# Convert Markdown (resume.md) to DOCX and PDF
# prerequisites(Mac): pandoc, basictex

RESUME = resume.md
REFERENCES = references.md
OUTPUT_DIR = output
BRANCH_NAME := $(shell git rev-parse --abbrev-ref HEAD)
FONTS_DIR = fonts

all: docx pdf

docx: resume-docx references-docx

resume-docx:
	@mkdir -p $(OUTPUT_DIR)
	pandoc $(RESUME) -o $(OUTPUT_DIR)/Isidore-resume-web.docx

references-docx:
	@mkdir -p $(OUTPUT_DIR)
	pandoc $(REFERENCES) -o $(OUTPUT_DIR)/references-web.docx

pdf: resume-pdf references-pdf

resume-pdf:
	@mkdir -p $(OUTPUT_DIR)
	cp -r $(FONTS_DIR)/* $(OUTPUT_DIR)/
	pandoc $(RESUME) -o $(OUTPUT_DIR)/Isidore-resume-web.pdf \
		--pdf-engine=xelatex \
		--variable mainfont="Roboto-Regular" \
		--variable boldfont="Roboto-Bold" \
		--variable geometry:margin=1cm \
		--variable fontsize=10pt \
		--variable documentclass=article \
		--variable classoption=twoside \
		--variable classoption=letter \
		--variable lang=en \
		--variable toc-depth=2 \
		--variable toc-own-page=true \
		--variable indent=true \
		--pdf-engine-opt=--shell-escape \
    --from markdown-markdown_in_html_blocks+raw_html

references-pdf:
	@mkdir -p $(OUTPUT_DIR)
	pandoc $(REFERENCES) -o $(OUTPUT_DIR)/references-web.pdf

clean:
	rm -rf $(OUTPUT_DIR)

.PHONY: all docx pdf clean

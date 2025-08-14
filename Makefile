CONTAINER_IMAGE = ghcr.io/xu-cheng/texlive-debian:latest
TEX_FILE = dusan-haustein-cv-eng.tex
PDF_FILE = $(TEX_FILE:.tex=.pdf)
WORK_DIR = $(shell pwd)

all: $(PDF_FILE)
# build the inside container
$(PDF_FILE): $(TEX_FILE)
	podman run --rm \
		-v $(WORK_DIR):/workspace:z \
		-w /workspace \
		$(CONTAINER_IMAGE) \
		pdflatex -interaction=nonstopmode $(TEX_FILE)

clean:
	rm -f *.pdf *.aux *.log *.out *.fdb_latexmk *.fls *.synctex.gz

rebuild: clean all

help:
	@echo "Available targets:"
	@echo "  all      - Build PDF from TEX file (default)"
	@echo "  clean    - Remove generated files"
	@echo "  rebuild  - Clean and build"
	@echo "  help     - Show this help message"

.PHONY: all clean rebuild help

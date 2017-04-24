
CHAPTERS := header.yml \
			01_Introduction.md \
			02_Getting_started.md \
			03_Basic_features.md \
			04_Premium_features.md \
 			05_Service_integration.md \
			06_Working_with_projects.md \
			07_Systemist.md \
			08_Afterword.md




SOURCE_CHAPTERS := $(foreach chapter,$(CHAPTERS),chapters/$(chapter))

PANDOC := pandoc

PANDOC_OPTS_ALL :=  --toc --smart --variable secnumdepth=0 \
					--top-level-division=chapter

PANDOC_PDF_OPTS := $(PANDOC_OPTS_ALL) \
					--default-image-extension=pdf \
					--metadata documentclass=scrbook \
					--metadata geometry=b5paper

PANDOC_EPUB_OPTS := $(PANDOC_OPTS_ALL) \
					--default-image-extension=png \
					-t epub3 --toc-depth=1 \
					--css=Medium-Style.css \
					--epub-cover-image=cover.png


all: book.pdf book.epub book.mobi

book.pdf: $(SOURCE_CHAPTERS) Makefile
	$(PANDOC) $(PANDOC_PDF_OPTS) -o $@ $(SOURCE_CHAPTERS)

book.epub: $(SOURCE_CHAPTERS) Makefile Medium-Style.css
	$(PANDOC) $(PANDOC_EPUB_OPTS) -o $@ $(SOURCE_CHAPTERS)

book.mobi: book.epub
	./kindlegen book.epub -o book.mobi

clean:
	rm book.pdf book.epub book.mobi

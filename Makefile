# Main Repository Directories
MAKEDIR = $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
SRCDIR = dhall-src
BUILDDIR = dhall-build
LIBDIR = /$(SRCDIR)/texmf/tex/latex

# Compile commands and files
# LATEXMK = latexmk -pdf -cd -use-make
LATEXMK = latexmk -pdf -cd

export TEXMFHOME=$(MAKEDIR)$(SRCDIR)/texmf

resumes_src = $(shell find $(SRCDIR) -name '*.tex.dhall')
resumes_pdf = $(patsubst $(SRCDIR)/%.tex.dhall,$(BUILDDIR)/%.pdf,$(resumes_src))


.PHONY : all cleanall clean FORCE

# Do not delete intermediate files
.SECONDARY :

all : $(resumes_pdf) FORCE

$(BUILDDIR)/%.pdf : $(BUILDDIR)/%.tex FORCE
	$(LATEXMK) $<

$(BUILDDIR)/%.tex : $(SRCDIR)/%.tex.dhall FORCE
	mkdir -p $(dir $@)
	dhall text --file $< --output $@

cleanall :
	rm -rf $(BUILDDIR)

clean :
	latexmk -c

FORCE:

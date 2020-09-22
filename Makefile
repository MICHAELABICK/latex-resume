# Main Repository Directories
SRCDIR = dhall-src
BUILDDIR = dhall-build
TESTDIR = test

MAKEDIR = $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
LIBDIR = /$(SRCDIR)/texmf/tex/latex

# Compile commands and files
# LATEXMK = latexmk -pdf -cd -use-make
LATEXMK = latexmk -pdf -cd

export TEXMFHOME=$(MAKEDIR)$(SRCDIR)/texmf

resumes_src = $(shell find $(SRCDIR) -name '*.tex.dhall')
resumes_pdf = $(patsubst $(SRCDIR)/%.tex.dhall,$(BUILDDIR)/%.pdf,$(resumes_src))

dhall_src = $(shell find $(SRCDIR) -name '*.dhall')
dhall_test = $(patsubst $(SRCDIR)/%,$(TESTDIR)/%,$(dhall_src))


.PHONY : all cleanall clean FORCE

# Do not delete intermediate files
.SECONDARY :

all : $(resumes_pdf) FORCE

$(BUILDDIR)/%.pdf : $(BUILDDIR)/%.tex FORCE
	$(LATEXMK) $<

$(BUILDDIR)/%.tex : $(SRCDIR)/%.tex.dhall FORCE
	mkdir -p $(dir $@)
	dhall text --file $< --output $@

test : $(dhall_test)

$(TESTDIR)/%.dhall : $(SRCDIR)/%.dhall FORCE
	dhall type --file $< --quiet

cleanall :
	rm -rf $(BUILDDIR)

clean :
	latexmk -c

FORCE:

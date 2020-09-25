# Main Repository Directories
SRCDIR = src
BUILDDIR = build
TESTDIR = test
APPDIR = $(SRCDIR)/applications

MAKEDIR = $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
LIBDIR = $(SRCDIR)/texmf/tex/latex

# Compile commands and files
# LATEXMK = latexmk -pdf -cd -use-make
LATEXMK = latexmk -pdf -cd

export TEXMFHOME=$(MAKEDIR)$(SRCDIR)/texmf

lib_files = $(shell find $(LIBDIR) -name '*')

tex_src = $(shell find $(APPDIR) -name '*.tex')
dhall_tex_src = $(shell find $(APPDIR) -name '*.tex.dhall')
tex_pdf = $(patsubst $(SRCDIR)/%.tex,$(BUILDDIR)/%.pdf,$(tex_src))
dhall_tex_pdf = $(patsubst $(SRCDIR)/%.tex.dhall,$(BUILDDIR)/%.pdf,$(dhall_tex_src))

dhall_src = $(shell find $(SRCDIR) -name '*.dhall')
dhall_test = $(patsubst $(SRCDIR)/%,$(TESTDIR)/%,$(dhall_src))


.PHONY : all cleanall clean FORCE

# Do not delete intermediate files
.SECONDARY :

all : $(tex_pdf) $(dhall_tex_pdf) FORCE

$(BUILDDIR)/%.pdf : $(BUILDDIR)/%.tex $(lib_files)
	$(LATEXMK) $<

$(BUILDDIR)/%.tex : $(SRCDIR)/%.tex FORCE
	mkdir -p $(dir $@)
	cp $< $@

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

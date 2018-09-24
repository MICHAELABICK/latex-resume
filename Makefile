# Main Repository Directories
MAKEDIR = $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
SRCDIR = src
BUILDDIR = build
LIBDIR = /$(SRCDIR)/texmf/tex/latex
# Source Directories
RESDIR = $(SRCDIR)/resumes
XMLDIR = $(SRCDIR)/TeXML_resume
LETDIR = $(SRCDIR)/cover_letters
PYDIR = $(SRCDIR)/python
# Compile commands and files
LATEXSTYLE = $(XMLDIR)/LaTeX_resume.xslt
TEXTSTYLE = $(XMLDIR)/text_resume.xslt
PREPROC = $(PYDIR)/preprocess.py
LATEXMK = latexmk -pdf -cd -use-make
XSLTPROC = xsltproc
TEXMLMK = texml
PYTHON = pipenv run python

export TEXMFHOME=$(MAKEDIR)$(SRCDIR)/texmf

# Source Files
resumes =     $(shell find $(RESDIR) -name '*.tex')
xml_resumes = $(shell find $(XMLDIR) -name '*.xml')
letters =     $(shell find $(LETDIR) -name '*.tex')
# resumes =     $(wildcard $(RESDIR)/**/*.tex)
# xml_resumes = $(wildcard $(XMLDIR)/**/*.xml)
# letters =     $(wildcard $(LETDIR)/**/*.tex)
# Copied Output Files
out_resumes =      $(patsubst $(SRCDIR)/%,$(BUILDDIR)/%,$(resumes))
out_xml_resumes =  $(patsubst $(SRCDIR)/%,$(BUILDDIR)/%,$(xml_resumes))
out_letters =      $(patsubst $(SRCDIR)/%,$(BUILDDIR)/%,$(letters))
# Generated Output Files
respdf =  $(patsubst %.tex,%.pdf,$(out_resumes))
xmlpdf =  $(patsubst %.xml,%.pdf,$(out_xml_resumes))
xmltex =  $(patsubst %.xml,%.tex,$(out_xml_resumes))
xmltexml =  $(patsubst %.xml,%.texml.xml,$(out_xml_resumes))
xmltext = $(patsubst %.xml,%.text,$(out_xml_resumes))
xmlproc = $(patsubst %.xml,%.proc.xml,$(out_xml_resumes))
letpdf =  $(patsubst %.tex,%.pdf,$(out_letters))

# all : $(respdf) $(letpdf) $(xmlpdf) $(xmltext)
all : $(respdf) $(letpdf) $(xmlpdf)
$(respdf) $(letpdf) $(xmlpdf) : FORCE
	$(LATEXMK) $(basename $@).tex
$(letpdf) : $(respdf)
.SECONDEXPANSION :
$(out_resumes) $(out_letters) $(out_xml_resumes) : $$(patsubst $$(BUILDDIR)/%,$$(SRCDIR)/%,$$@)
	# create the directory structure if it does not exist already
	mkdir -p $(dir $@)
	# if source files change, copy them over to the output directory
	cp $< $(dir $@)
# TODO: Determine whether the -use-make option will call make
#       on the tex file, making this next line unneccesary
$(respdf) $(letpdf) $(xmlpdf) : $$(basename $$@).tex
$(xmltex) : $$(basename $$@).texml.xml
	$(TEXMLMK) $< $@
$(xmltexml) : $$(patsubst %.texml.xml,%.proc.xml,$$@)  $(LATEXSTYLE)
	$(XSLTPROC) $(LATEXSTYLE) $< > $@
$(xmltext) : $$(basename $$@).proc.xml $(TEXTSTYLE)
	$(XSLTPROC) $(TEXTSTYLE) $< > $@
$(xmlproc) : $$(patsubst %.proc.xml,%.xml,$$@) $(PREPROC)
	$(PYTHON) $(PREPROC)
# Assuming latexmk can find dependencies correctly, we can just force
# latexmk to run every time a tex file needs to be generated, and we
# dont actually need to track dependencies seperately
# $(resumes) : $(LIBDIR)/resume.cls
# $(letters) : $(LIBDIR)/cover_letter.cls
# $(LIBDIR)/resume.cls $(LIBDIR)/cover_letter.cls : $(LIBDIR)/pro_letterhead.tex
cleanall :
	rm -rf $(BUILDDIR)
clean :
	latexmk -c
.PHONY : all cleanall clean FORCE

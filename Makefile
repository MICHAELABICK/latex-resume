MAKEDIR = $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
SRCDIR = src
LIBDIR = /$(SRCDIR)/texmf/tex/latex
RESDIR = $(SRCDIR)/resumes
XMLDIR = $(SRCDIR)/XML_resume
LETDIR = $(SRCDIR)/cover_letters
LATEXSTYLE = $(XMLDIR)/LaTeX_resume.xslt
TEXTSTYLE = $(XMLDIR)/text_resume.xslt

export TEXMFHOME=$(MAKEDIR)$(SRCDIR)/texmf

resumes = $(shell find $(RESDIR) -name '*.tex')
xml_resumes = $(shell find $(XMLDIR) -name '*.xml')
letters = $(shell find $(LETDIR) -name '*.tex')
respdf = $(patsubst %.tex,%.pdf,$(resumes))
xmlpdf = $(patsubst %.xml,%.pdf,$(xml_resumes))
xmltex = $(patsubst %.xml,%.tex,$(xml_resumes))
xmltext = $(patsubst %.xml,%.text,$(xml_resumes))
letpdf = $(patsubst %.tex,%.pdf,$(letters))

# %.tex: ;
# %.cls: ;

all : $(respdf) $(letpdf) $(xmlpdf) $(xmltext)
$(respdf) $(letpdf) $(xmlpdf) : FORCE
	latexmk -pdf -cd -use-make $(basename $@).tex
$(letpdf) : $(respdf)
.SECONDEXPANSION :
# TODO: Determine whether the -use-make option will call make
#       on the tex file, make this next line unneccesary
$(xmlpdf) : $$(basename $$@).tex
$(xmltex) : $$(basename $$@).xml $(LATEXSTYLE)
	xsltproc $(LATEXSTYLE) $< > $@
$(xmltext) : $$(basename $$@).xml $(TEXTSTYLE)
	xsltproc $(TEXTSTYLE) $< > $@
# Assuming latexmk can find dependencies correctly, we can just force
# latexmk to run every time a tex file needs to be generated, and we
# dont actually need to track dependencies seperately
# .SECONDEXPANSION :
# $(RESDIR)/resume.pdf $(letpdf) : $$(basename $$@).tex
# 	latexmk -pdf  -cd -use-make $<
# $(resumes) : $(LIBDIR)/resume.cls
# $(letters) : $(LIBDIR)/cover_letter.cls
# $(LIBDIR)/resume.cls $(LIBDIR)/cover_letter.cls : $(LIBDIR)/pro_letterhead.tex
cleanall :
	latexmk -C
clean :
	latexmk -c
.PHONY : all cleanall clean FORCE

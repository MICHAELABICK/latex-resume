MAKEDIR = $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
LIBDIR = /texmf/tex/latex
RESDIR = resumes
XMLDIR = XML_resume
LETDIR = cover_letters
RESSTYLE = $(XMLDIR)/resume.xslt

export TEXMFHOME=$(MAKEDIR)texmf

resumes = $(shell find $(RESDIR) -name '*.tex')
xml_resumes = $(shell find $(XMLDIR) -name '*.xml')
letters = $(shell find $(LETDIR) -name '*.tex')
respdf = $(patsubst %.tex,%.pdf,$(resumes))
xmlpdf = $(patsubst %.xml,%.pdf,$(xml_resumes))
xmltex = $(patsubst %.xml,%.tex,$(xml_resumes))
letpdf = $(patsubst %.tex,%.pdf,$(letters))

# %.tex: ;
# %.cls: ;

all : $(respdf) $(letpdf) $(xmlpdf)
$(respdf) $(letpdf) $(xmlpdf) : FORCE
	latexmk -pdf -cd -use-make $(basename $@).tex
$(letpdf) : $(respdf);
.SECONDEXPANSION :
$(xmlpdf) : $$(basename $$@).xml
	xsltproc $(RESSTYLE) $@ > $<
# Assuming latexmk can find dependencies correctly, we can just force
# latexmk to run every time a tex file needs to be generated, and we
# dont actually need to track dependencies seperately
# .SECONDEXPANSION :
# $(RESDIR)/resume.pdf $(letpdf) : $$(basename $$@).tex
# 	latexmk -pdf  -cd -use-make $<
# $(resumes) : $(LIBDIR)/resume.cls;
# $(letters) : $(LIBDIR)/cover_letter.cls;
# $(LIBDIR)/resume.cls $(LIBDIR)/cover_letter.cls : $(LIBDIR)/pro_letterhead.tex;
cleanall :
	latexmk -C
clean :
	latexmk -c
.PHONY : all cleanall clean FORCE

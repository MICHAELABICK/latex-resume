MAKEDIR = $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
LIBDIR = /texmf/tex/latex
RESDIR = resumes
LETDIR = cover_letters

export TEXMFHOME=$(MAKEDIR)texmf

resumes = $(shell find $(RESDIR) -name '*.tex')
letters = $(shell find $(LETDIR) -name '*.tex')
respdf = $(patsubst %.tex,%.pdf,$(resumes))
letpdf = $(patsubst %.tex,%.pdf,$(letters))

# %.tex: ;
# %.cls: ;

all : $(respdf) $(letpdf)
$(respdf) $(letpdf) : FORCE
	latexmk -pdf -cd -use-make $(basename $@).tex
$(letpdf) : $(respdf)
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

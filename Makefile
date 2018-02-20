export TEXMFHOME=texmf

LIBDIR = /texmf/tex/latex
RESDIR = resumes
LETDIR = cover_letters

resumes = $(wildcard $(RESDIR)/**/*.tex)
letters = $(wildcard $(LETDIR)/**/*.tex)
respdf = $(patsubst %.tex,%.pdf,$(resumes))
letpdf = $(patsubst %.tex,%.pdf,$(letters))

%.tex: ;
%.cls: ;

all : $(respdf) $(letpdf)
.SECONDEXPANSION:
$(RESDIR)/resume.pdf $(letpdf) : $$(basename $$@).tex
# $(respdf) $(letpdf) : $$(basename $$@).tex
	echo $(respdf)
	latexmk -pdf -outdir=$(<D) -use-make $<
$(resumes) : $(LIBDIR)/resume.cls;
$(letters) : $(LIBDIR)/cover_letter.cls;
$(LIBDIR)/resume.cls $(LIBDIR)/cover_letter.cls : $(LIBDIR)/pro_letterhead.tex;
cleanall :
	latexmk -C
clean :
	latexmk -c
.PHONY : all cleanall clean

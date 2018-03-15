# Main Repository Directories
MAKEDIR = $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
SRCDIR = src
OUTDIR = output
LIBDIR = /$(SRCDIR)/texmf/tex/latex
# Source Directories
RESDIR = $(SRCDIR)/resumes
XMLDIR = $(SRCDIR)/XML_resume
LETDIR = $(SRCDIR)/cover_letters
# Compile commands and files
LATEXSTYLE = $(XMLDIR)/LaTeX_resume.xslt
TEXTSTYLE = $(XMLDIR)/text_resume.xslt

export TEXMFHOME=$(MAKEDIR)$(SRCDIR)/texmf

# Source Files
resumes =     $(shell find $(RESDIR) -name '*.tex')
xml_resumes = $(shell find $(XMLDIR) -name '*.xml')
letters =     $(shell find $(LETDIR) -name '*.tex')
# Copied Output Files
out_resumes =      $(patsubst $(SRCDIR)/%,$(OUTDIR)/%,$(resumes))
out_xml_resumes =  $(patsubst $(SRCDIR)/%,$(OUTDIR)/%,$(xml_resumes))
out_letters =      $(patsubst $(SRCDIR)/%,$(OUTDIR)/%,$(letters))
# Generated Output Files
respdf =  $(patsubst %.tex,%.pdf,$(out_resumes))
xmlpdf =  $(patsubst %.xml,%.pdf,$(out_xml_resumes))
xmltex =  $(patsubst %.xml,%.tex,$(out_xml_resumes))
xmltext = $(patsubst %.xml,%.text,$(out_xml_resumes))
letpdf =  $(patsubst %.tex,%.pdf,$(out_lout_etters))

# %.tex: ;
# %.cls: ;

# all : $(respdf) $(letpdf) $(xmlpdf) $(xmltext)
all : $(respdf) $(letpdf)
$(respdf) $(letpdf) $(xmlpdf) : FORCE
	latexmk -pdf -cd -use-make $(basename $@).tex
$(letpdf) : $(respdf)
.SECONDEXPANSION :
# if source files change, copy them over to the output directory
$(out_resumes) $(out_letters) $(out_xml_resumes) : $$(patsubst $$(OUTDIR)/%,$$(SRCDIR)/%,$$@)
	# create the directory structure if it does not exist already
	mkdir -p $(dir $@)
	cp $< $(dir $@)
# TODO: Determine whether the -use-make option will call make
#       on the tex file, making these next two lines unneccesary
$(respdf) $(letpdf) : $$(basename $$@).tex
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

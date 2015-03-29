# master makefile for dot files
#
# todo
#	merge with master tex file or call it from there, smthg like that
#
# 2012.06.29 Copyright Ioannis Filippidis

CDOT = dot
PDFFLAGS = -Tpdf
SVGFLAGS = -Tsvg

dot_file := $(wildcard *.dot)
dot_file := $(subst .dot,,$(dot_file))

all: svg

pdf:
	@for i in $(dot_file);\
		do \
			echo "converting graph from dot -> pdf: $$i";\
			$(CDOT) $(PDFFLAGS) $$i.dot -o $$i.pdf;\
		done

svg:
	@for i in $(dot_file);\
		do \
			echo "converting graph from dot -> svg $$i";\
			$(CDOT) $(SVGFLAGS) $$i.dot -o $$i.svg;\
		done

clean:
	rm *.pdf *.svg


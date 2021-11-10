NAME = main
TARG = $(NAME).tex
GOAL = $(NAME).pdf
ENGINE = lualatex

PY_COMP = pythontex
PY_AUX_DIR = pythontex-files-$(NAME)
PY_AUX_FILES = $(NAME).pytxcode

SCRLOC = scripts
SECTIONER = $(SCRLOC)/new_sec.py
PYTHON = python3

EDITOR = kate
SRC_FILES = *.tex */*.tex

PDF_TOOL = okular

# Set up for open
SOURCES = $(HOME)
TAIL = 2> /dev/null &

build:
	latexmk -pdf $(TARG) -$(ENGINE)

pythontex:
	latexmk -pdf $(TARG) -$(ENGINE)
	$(PY_COMP) $(TARG) --interpreter python:python3
	$(ENGINE) $(TARG)

clean:
	latexmk -c

wipe:
	latexmk -C
ifeq ($(wildcard $(PY_AUX_DIR)), $(PY_AUX_DIR))
	rm -r $(PY_AUX_DIR)
endif
ifeq ($(wildcard $(PY_AUX_FILES)), $(PY_AUX_FILES))
	rm -r $(PY_AUX_FILES)
endif

section:
	$(PYTHON) $(SECTIONER) section

chapter:
	$(PYTHON) $(SECTIONER) chapter

open:
	$(EDITOR) $(SRC_FILES) $(TAIL)
ifneq ($(SOURCES), $(HOME))
	$(PDF_TOOL) $(SOURCES) $(TAIL)
endif

git_start:
	$(MAKE) git_rm
	touch README.md
	git init

git_rm:
	rm README.md
ifeq ($(wildcard .git), .git)
	rm -rf .git
endif


git_quick:
	git add -u
	git status
	sleep 5
	git commit
	git push origin HEAD

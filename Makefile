NAME = main
TARG = $(NAME).tex
GOAL = $(NAME).pdf
ENGINE = lualatex


PY_COMP = pythontex
PY_AUX_DIR = pythontex-files-$(NAME)
PY_AUX_FILES = $(NAME).pytxcode

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
	python3 internal_packages/new_sec.py section

chapter:
	python3 internal_packages/new_sec.py chapter

open:
	$(EDITOR) $(SRC_FILES) $(TAIL)
ifneq ($(SOURCES), $(HOME))
	$(PDF_TOOL) $(SOURCES) $(TAIL)
endif

git_start:
	rm -rf .git
	git init

git_rm:
	rm -rf .git_quick
	rm README.md

git_quick:
	git add -u
	git status
	sleep 5
	git commit
	git push origin HEAD

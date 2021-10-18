COMP = lualatex
NAME = main
TARG = $(NAME).tex
GOAL = $(NAME).pdf
FINISH_NAME = $(NAME).pdf

AUX_FILES = $(NAME).aux $(NAME).log $(NAME).out $(NAME).toc

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
	$(COMP) $(TARG)

all:
	$(COMP) $(TARG)
# Descomentar en caso de usar pythontex
# 	$(PY_COMP) $(TARG)
	$(COMP) $(TARG)

clear:
ifeq ($(wildcard $(PY_AUX_DIR)), $(PY_AUX_DIR))
	rm -r $(PY_AUX_DIR)
endif
ifeq ($(wildcard $(PY_AUX_FILES)), $(PY_AUX_FILES))
	rm -r $(PY_AUX_FILES)
endif
ifeq ($(wildcard $(AUX_FILES)), $(AUX_FILES))
	rm $(AUX_FILES)
endif

clean:
	$(MAKE) clear
ifeq ($(wildcard $(GOAL)),$(GOAL))
	rm $(GOAL)
endif

finish: $(GOAL)
ifeq ($(FINISH_NAME),$(GOAL))
	$(MAKE) clear
else
ifeq ($(wildcard $(GOAL)), $(GOAL))
	mv $(GOAL) $(FINISH_NAME)
endif
	$(MAKE) clean
endif

$(GOAL):
	$(MAKE) all

open:
	$(EDITOR) $(SRC_FILES) $(TAIL)
ifneq ($(SOURCES), $(HOME))
	$(PDF_TOOL) $(SOURCES) $(TAIL)
endif

start_git:
	rm -rf .git
	git init

git_quick:
	git add -u
	git commit
	git push origin HEAD

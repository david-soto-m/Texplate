COMP = lualatex
NAME = main
TARG = $(NAME).tex
GOAL = $(NAME).pdf
FINISH_NAME = $(NAME).pdf

AUX_FILES = $(NAME).aux $(NAME).log $(NAME).out $(NAME).toc

PY_COMP = pythontex
PY_AUX_DIR = pythontex-files-$(NAME)
PY_AUX_FILES = $(NAME).pytxcode


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

finish:
ifeq ($(FINISH_NAME),$(GOAL))
	$(MAKE) clear
else
ifeq ($(wildcard $(GOAL)), $(GOAL))
	mv $(GOAL) $(FINISH_NAME)
endif
	$(MAKE) clean
endif

open:
	kate *.tex
	kate */*.tex

git_quick:
	git add -u
	git commit
	git push origin HEAD

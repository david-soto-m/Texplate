# Texplate

(Lua)latex/ latexmk template for engineering lab reports and similar stuff.
Centered around being able to include code, figures, math ...

This is meant as a `main.tex` that inputs or includes the other parts of the
project.

---

## Makefile

### variables

* `NAME = main`: Name for the output pdf and `.tex` file to compile
* `TARG = $(NAME).tex`: Name of the tex file to be compiled
* `ENGINE = lualatex`: Compilation engine
  `
* `PY_COMP = pythontex`: python compilator
* `PY_AUX_DIR = pythontex-files-$(NAME)`: where the pythontex auxiliary
directory is going to be
* `PY_AUX_FILES = $(NAME).pytxcode`: where the pythontex auxiliary files are
going to be
  `
* `SCRLOC = scripts`: Where you should store your scripts
* `SECTIONER = $(SCRLOC)/new_sec.py:` [The auxiliary script](#Helper-Script)
* `PYTHON = python3`: python command to run
  `
* `EDITOR = kate`: Your text editor
* `SRC_FILES = *.tex */*.tex`: All '.tex' files in the project
  `
* `PDF_TOOL = okular`: The command to open pdf files
  `
* `SOURCES = $(HOME)`: All the pdfs to open at the beggining of the project
* `TAIL = 2> /dev/null &`: Where errors should be logged, usefull if your tex
editor blocks the command line.



### Default / lint

Use chktex for latex style. It won't check spelling, grammar, writing style...
To check that, [spellboy](https://www.spellboy.com/check_spelling/) is a
personal favorite.

### build

A run of latexmk. You only need it to run once, as it compiles as many times as
it needs to make sure to get all your references and other things right.

### cont

Start a continuous session of latexmk. It will get stuck when you introduce
some bad latex, such as an environment that is not properly closed, a bad
reference.... Most of the time you can fix your problem and then press
`Control-d` to keep the run or `Control-c` to exit it before reentering it.
Sometimes it can get really stuck and you may need to open up a terminal and
kill it with `pkill -KILL lualatex`. It looks scary but is really worth it and
time saving, having (kinda of) immediate feedback on what you have just written.

### pythontex

Runs a latexmk, then pythontex then a last run of the selected engine.

### clean

A soft clean that cleans the auxiliary build files.

### wipe

A hard clean that eliminates all auxiliary files, the generated pdf and if they
exist auxiliary pythontex files

### section

Creates a new empty section with a figures directory. The resulting file must
be added to the `main.tex` file.

### chapter

Creates a new empty chapter with a figures directory. The resulting file must
be added to the `main.tex` file.

### appendix

Creates a new empty appendix chapter with a figures directory. The resulting
file must be added to the `main.tex` file after the `\appendix` command.


### appensec

Creates a new empty appendix section with a figures directory. The resulting
file must be added to the `main.tex` file after the `\appendix` command.

### open

Open all `.tex` files in the project and pdf sources you have included in the
`SOURCES` variable.

### git_start

Eliminate the existing git project and start a new one.

### git_rm

Eliminate the existing git project

### git_quick

1. Add updated files to commit.
2. Show the status so that you can cancel the command if something should be
changed.
3. Commit.
4. Push to HEAD, normally the branch in which you are.

---

## Helper Script

There is a `python3` helper script called `new_sec` to create new chapters and
sections. It will create a file with a name like `sec_1` or `ch_14` in whatever
directory is called.

There are a number of keywords pre-programmed for it.

* **chapter**
* **appendix**
* **section**
* **subsection**
* **appendix_sec**

The other way you can use this script is by giving it two or three arguments.
The first one is the label, folder name and file name that should be used to
identify your part. The second one is the command that should be used for your
part. The optional third one is a path to a custom template starting from the
scripts directory.

The template should only receive two variables, `{0}` and `{1}`. To use
brackets you should double them, for example: `{{itemize}}`

Examples:

```bash
python3 scripts/new_sec.py section
python3 scripts/new_sec.py z_ap "\section{}"
python3 scripts/new_sec.py special_chapter "\chapter{}" "template_1.txt"
```

To add a new keyword, just add it to the types dictionary in
`scripts/new_sec.py`. You may also want to modify the `Makefile` file to add a
shortcut to it.

---

## Frequent modifications

### Language

It uses Spanish by default, beware if using another language.
To amend this `.kateconfig` and `internal_packages/other.sty` should be changed.
If you are not using the [Kate](https://kate-editor.org/) editor you shouldn't
have problems with the `.kateconfig` file

### Fonts

The fonts package is bound to give you some trouble, change fonts there to fonts
you have available on your system. It is also the only part that requires
lualatex. If you don't want to use lualatex change so in the `Makefile` and
either modify or comment out that package.

The Geomanist font is a proprietary font. You can acquire it from the atipo
foundry from [their website](https://www.atipofoundry.com/fonts/geomanist) on a
pay what you want basis starting from 15€.

### Splitting paragraphs

By default it avoids splitting paragraphs over different pages, to allow for
that you must comment line 7 in `internal_packages/other.sty`.


### Biblatex/Biber

By default the bibliography is processed with Biber. If you want to process it
with Biblatex but you have compiled once with Biber activated, you will have to
wipe you compilation with `make wipe` and then compile again. In order to
use Biblatex you only have to uncomment the line in
`internal_packages/bibliography.sty`

### Pythontex

To use pythontex remove `.latexmkrc` out directory and use `make pythontex`
You might need to install pygments with `pip install pygments`

---

## Learn

For a quick latex tutorial check [this site](https://latex-tutorial.com/).
For a more extensive tutorials check
[this other site](https://www.overleaf.com/learn)

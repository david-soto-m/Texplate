# Texplate

(Lua)latex/ latexmk template for engineering lab reports and similar stuff.
Centered around being able to code and put figures and math and formulas.
Also style.

For a quick tutorial check [this site](https://latex-tutorial.com/). For a more
extensive tutorial check [this other site](https://www.overleaf.com/learn)


It uses Spanish by default, beware if using another language.
To amend this `.kateconfig` and `internal_packages/other.sty` should be changed.

This is meant as a `main.tex` that inputs or includes the other parts of the
project.

To use pythontex remove `.latexmkrc` out directory and use `make pythontex`
You might need to install pygments with `pip install pygments`

The fonts package is bound to give you some trouble, change fonts there to fonts
you have available on your system. It is also the only part that requires
lualatex. If you don't want to use lualatex change so in the `Makefile` and
either modify or comment out that package.

The Geomanist font is a proprietary font. You can acquire it from the atipo
foundry from [their website](https://www.atipofoundry.com/fonts/geomanist) on a
pay what you want basis starting from 15€.

There is a python helper script called `new_sec` to create new chapters and
sections. It will create a file with a name like `sec_1` or `ch_14` in whatever
directory is called. There are some make shortcuts to it.

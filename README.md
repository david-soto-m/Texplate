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

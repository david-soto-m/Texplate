#!/usr/bin/python3

from os import listdir, mkdir
from pathlib import Path
from sys import argv

types = {
        'subsection': {
            'short': 'sub_',
            'command': '\\subsection{}',
            },
        'section': {
            'short': 'sec_',
            'command': '\\section{}',
            },
        'chapter': {
            'short': 'ch_',
            'command': '\\chapter{}',
            }
    }

if len(argv) == 2:
    typ = types[argv[1]]
elif len(argv) == 3:
    if argv[1][-1] == '_':
        argv[1]=argv[1][0:-1]
    typ = {
        'short': argv[1].replace('_','-') + '_',
        'command': argv[2],
        }
else:
    typ = types['section']

elements = [int(i.split('_')[1]) for i in listdir() if typ['short'] in i]
elements.sort(reverse=True)
if elements == []:
    elements = [0]

name = typ['short'] + str(elements[0] + 1)
mkdir(name)

with open(Path(__file__).parent / 'template.tex', 'r') as f:
    templ = f.read()
    solved = templ.format(typ['command'], '{' + name + '}')
    f.close()
    with open(name + '/' + name + '.tex', 'w') as g:
        g.write(solved)
        g.close()

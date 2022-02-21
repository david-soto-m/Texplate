#!/usr/bin/python3

from os import listdir, mkdir
from pathlib import Path
from sys import argv

def_temp_file = Path(__file__).parent / 'template.txt'

types = {
        'subsection': {
            'short': 'sub_',
            'command': '\\subsection{}',
            'temp_file': def_temp_file,
            },
        'section': {
            'short': 'sec_',
            'command': '\\section{}',
            'temp_file': def_temp_file,
            },
        'chapter': {
            'short': 'ch_',
            'command': '\\chapter{}',
            'temp_file': def_temp_file,
            },
        'appendix': {
            'short': 'ap_',
            'command': '\\chapter{}',
            'temp_file': def_temp_file,
        },
        'appendix_sec': {
            'short': 'ap_',
            'command': '\\section{}',
            'temp_file': def_temp_file,
        },
    }


if len(argv) == 2:
    typ = types[argv[1]]
elif 3 <= len(argv) <= 4:
    if argv[1][-1] == '_':
        argv[1] = argv[1][0:-1]
    if len(argv) == 4:
        temp_file = Path(__file__).parent / argv[3]
    else:
        temp_file = def_temp_file
    typ = {
        'short': argv[1] + '_',
        'command': argv[2],
        'temp_file': temp_file
        }
else:
    typ = types['section']

elements = [int(i.split('_')[-1]) for i in listdir() if typ['short'] in i]
elements.sort(reverse=True)
if elements == []:
    elements = [0]

name = typ['short'] + str(elements[0] + 1)
mkdir(name)
mkdir(name + "/figures")

with open(typ['temp_file'], 'r') as f:
    templ = f.read()
    solved = templ.format(typ['command'], '{' + name + '}')
    f.close()
    with open(name + '/' + name + '.tex', 'w') as g:
        g.write(solved)
        g.close()

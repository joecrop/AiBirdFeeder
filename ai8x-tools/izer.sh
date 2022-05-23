#!/bin/bash
# Intended for use with MSYS2
HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $HERE/ai8x-synthesis
source venv/Scripts/activate
echo ai8x-synthesis environment activated.
echo Run 'Python ai8xize.py -h' for help.
echo Run 'deactivate' to deactivate.
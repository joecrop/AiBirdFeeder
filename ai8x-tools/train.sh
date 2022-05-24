#!/bin/bash
# Intended for use with MSYS2
HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $HERE/ai8x-training
source /c/MaximSDK/Tools/ai8x-tools/ai8x-training/venv/Scripts/activate
echo ai8x-training environment activated.
echo Run 'Python train.py -h' for help.
echo Run 'deactivate' to deactivate.
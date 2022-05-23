@echo off
set HERE="%~dp0"
cd %HERE%\ai8x-synthesis
call venv\Scripts\activate
echo ai8x-synthesis environment activated.
echo Run 'Python train.py -h' for help.
echo Run 'deactivate' to deactivate.
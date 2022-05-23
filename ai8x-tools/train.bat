@echo off
set HERE="%~dp0"
cd %HERE%\ai8x-training
call venv\Scripts\activate
echo ai8x-training environment activated.
echo Run 'Python train.py -h' for help.
echo Run 'deactivate' to deactivate.
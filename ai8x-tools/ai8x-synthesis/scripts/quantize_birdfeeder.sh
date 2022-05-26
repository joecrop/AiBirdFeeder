#!/bin/sh
python quantize.py trained/ai85-birdfeeder.pth.tar trained/ai85-birdfeeder_qat.pth.tar --device MAX78000 -v "$@"

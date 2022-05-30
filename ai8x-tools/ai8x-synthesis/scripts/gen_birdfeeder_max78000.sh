#!/bin/sh
DEVICE="MAX78000"
TARGET="../../"
COMMON_ARGS="--device $DEVICE --compact-data --mexpress --timer 0 --display-checkpoint --verbose"

python ai8xize.py --test-dir $TARGET --prefix birdfeeder --checkpoint-file trained/ai85-birdfeeder_qat.pth.tar --config-file networks/birdfeeder-hwc.yaml --fifo --softmax $COMMON_ARGS "$@"

# revert fiels that we don't want changed
git restore ../../birdfeeder/.vscode/
git restore ../../birdfeeder/.settings/
git restore ../../birdfeeder/.cproject
git restore ../../birdfeeder/.project
git restore ../../birdfeeder/main.c
git restore ../../birdfeeder/Makefile
#!/bin/sh
DEVICE="MAX78000"
TARGET="../../bird_feeder"
COMMON_ARGS="--device $DEVICE --compact-data --mexpress --timer 0 --display-checkpoint --verbose"

python ai8xize.py --test-dir $TARGET --prefix birdfeeder --checkpoint-file trained/trained/ai85-birdfeeder_qat.pth.tar --config-file networks/birdfeeder-hwc.yaml --fifo --softmax $COMMON_ARGS "$@"

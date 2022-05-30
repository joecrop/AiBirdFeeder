#!/bin/sh
python train.py --model ai85cdnet --dataset birdfeeder --confusion --evaluate --exp-load-weights-from ../ai8x-synthesis/trained/ai85-birdfeeder_qat.pth.tar -8 --device MAX78000 --save-sample 10 "$@"
mkdir -p ../ai8x-synthesis/tests
cp sample_birdfeeder.npy ../ai8x-synthesis/tests/.
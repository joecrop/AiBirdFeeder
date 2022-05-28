#!/bin/sh
python train.py --epochs 250 --optimizer Adam --lr 0.001 --wd 0 --deterministic --compress policies/schedule-birdfeeder.yaml --model ai85cdnet --dataset birdfeeder --confusion --param-hist --embedding --device MAX78000 "$@"

OLDEST_LOG=`ls -tr logs | tail -n 1`
cp logs/$OLDEST_LOG/best.pth.tar ../ai8x-synthesis/trained/ai85-birdfeeder.pth.tar
cp logs/$OLDEST_LOG/qat_best.pth.tar ../ai8x-synthesis/trained/ai85-birdfeeder_qat.pth.tar
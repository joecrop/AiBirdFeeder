# AiBirdFeeder
A bird feeder that uses AI to stop squirrels from eating the seed

## Prerequisites

- Maxim SDK

## Training

Pull the code needed to run the tools:

```bash
cd ai8x-tools
git submodule update --init --recursive
git pull --recurse-submodules --jobs=10
git clone --single-branch --branch pytorch-1.8 https://github.com/MaximIntegratedAI/distiller.git
```

Once the initial setup is done, you can jsut source train.sh from then on.

```bash
cd ai8x-tools
source train.sh
```

Now you can launch the training:

```bash
./scripts/train_birdfeeder.sh
# Or, if you don't have a good GPU:
#./scripts/train_birdfeeder.sh --workers=1
```

## Synthesis

```bash
cd ai8x-tools
deactivate
source izer.sh
```


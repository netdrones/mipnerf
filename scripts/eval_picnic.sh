#!/bin/bash

SCENE=picnic
EXPERIMENT=demo
TRAIN_DIR=results/$EXPERIMENT/$SCENE
DATA_DIR=picnic_nerf_001

python -m eval \
  --data_dir=$DATA_DIR \
  --train_dir=$TRAIN_DIR \
  --chunk=3076 \
  --gin_file=configs/picnic.gin \
  --logtostderr

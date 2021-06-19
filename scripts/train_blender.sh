#!/bin/bash

SCENE=lego
EXPERIMENT=debug
TRAIN_DIR=results/$EXPERIMENT/$SCENE
DATA_DIR=nerf_synthetic/$SCENE

python -m train \
  --data_dir=$DATA_DIR \
  --train_dir=$TRAIN_DIR \
  --gin_file=configs/blender.gin \
  --logtostderr

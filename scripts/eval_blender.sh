#!/bin/bash

SCENE=lego
EXPERIMENT=debug
TRAIN_DIR=results/$EXPERIMENT/$SCENE
DATA_DIR=nerf_data/nerf_synthetic/$SCENE

python -m eval \
  --data_dir=$DATA_DIR \
  --train_dir=$TRAIN_DIR \
  --chunk=3076 \
  --gin_file=configs/blender.gin \
  --logtostderr

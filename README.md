# mip-NeRF

This repository contains the code release for
[Mip-NeRF: A Multiscale Representation for Anti-Aliasing Neural Radiance Fields](https://jonbarron.info/mipnerf/).
This implementation is written in [JAX](https://github.com/google/jax), and
is a fork of Google's [JaxNeRF implementation](https://github.com/google-research/google-research/tree/master/jaxnerf).
Contact [Jon Barron](https://jonbarron.info/) if you encounter any issues.

![rays](https://user-images.githubusercontent.com/3310961/118305131-6ce86700-b49c-11eb-99b8-adcf276e9fe9.jpg)

## Installation

Simply run the following:

```bash
make install
conda activate mipnerf
```

To ensure that `jax` is using the GPU, open up a Python interpreter and run the following commands:

```python3
from jax.lib import xla_bridge
print(xla_bridge.get_backend().platform)
```

Make sure the following line is in the `~/.bash_profile`:

```bash
export LD_LIBRARY_PATH=/usr/local/cuda-10.2/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
```

### Generate multiscale dataset
You can generate the multiscale dataset used in the paper by running the following command,
```
python scripts/convert_blender_data.py --blenderdir /nerf_synthetic --outdir /multiscale
```

## Running

Example scripts for training mip-NeRF on individual scenes from the three
datasets used in the paper can be found in `scripts/`. You'll need to change
the paths to point to wherever the datasets are located.
[Gin](https://github.com/google/gin-config) configuration files for our model
and some ablations can be found in `configs/`.
An example script for evaluating on the test set of each scene can be found
in `scripts/`, after which you can use `scripts/summarize.ipynb` to produce
error metrics across all scenes in the same format as was used in tables in the
paper.

### OOM errors
You may need to reduce the batch size to avoid out of memory errors. For example the model can be run on a NVIDIA 3080 (10Gb) using the following flag.
```
--gin_param="Config.batch_size = 1024"
```

## Citation
If you use this software package, please cite our paper:

```
@misc{barron2021mipnerf,
      title={Mip-NeRF: A Multiscale Representation for Anti-Aliasing Neural Radiance Fields},
      author={Jonathan T. Barron and Ben Mildenhall and Matthew Tancik and Peter Hedman and Ricardo Martin-Brualla and Pratul P. Srinivasan},
      year={2021},
      eprint={2103.13415},
      archivePrefix={arXiv},
      primaryClass={cs.CV}
}
```

## Acknowledgements
Thanks to [Boyang Deng](https://boyangdeng.com/) for JaxNeRF.

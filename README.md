# NetDrones mip-NeRF Fork

This repository contains the NetDrones fork of [Mip-NeRF: A Multiscale Representation for Anti-Aliasing Neural Radiance Fields](https://jonbarron.info/mipnerf/), which extends it to automatically run on real-world data.

![rays](https://user-images.githubusercontent.com/3310961/118305131-6ce86700-b49c-11eb-99b8-adcf276e9fe9.jpg)

## Installation

This repository requires a specific GCP machine image to run. To spin this GCP instance, first run:

```bash
make gcp
```

Then, after waiting 30 or so seconds, run:

```bash
make connect
```

If the command fails, just keep running it until it does. Upon success, you should have ssh access to the correct
machine image.

Now, clone this repository onto the new image and install all dependencies:

```bash
cd ~/ws/git && git clone git@github.com/netdrones/mipnerf.git
cd mipnerf
make install
conda activate mipnerf
```

If not already on the machine, this will install `CUDA-10.1`. Note that this installation will automatically
reboot the GCP instance, so you will have to reconnect.

To ensure that `jax` is using the GPU, open up a Python interpreter and run the following commands:

```python3
from jax.lib import xla_bridge
print(xla_bridge.get_backend().platform)
```

In the event that this returns `cpu`, something has gone wrong, and you should try the following two steps.

1. Make sure the following are in the `~/.bash_profile`:

```bash
if [ -d "/usr/local/cuda-10.1/bin/" ]; then
    export PATH=/usr/local/cuda-10.1/bin${PATH:+:${PATH}}
    export LD_LIBRARY_PATH=/usr/local/cuda-10.1/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
fi
export LD_LIBRARY_PATH=/usr/local/cuda-10.2/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
```

2. Install a different version of `jaxlib`. In the `Makefile` in this directory, change the line that reads

```bash
pip install --upgrade jax jaxlib==0.1.67+cuda101 -f http://storage.googleapis.com/jax-releases/jax_releases.html
```

to

```bash
`pip install --upgrade jax jaxlib==0.1.65+cuda101 -f http://storage.googleapis.com/jax-releases/jax_releases.html`.
```

Test if `jax` is connecting to the GPU once again. If still not, proceed to step 3.

3. Reinstall `CUDA-10.1` by running `make cuda`.

If after these two steps `jax` is still not using the GPU, contact @lucas.

## Running

To train a `mipNeRF` on the picnic shelter dataset, run:

```bash
make picnic
```

To generate synthetic images using the `Blender` lego dataset, run:

```bash
make lego
```

include include.mk

PICNIC_DIR = picnic_nerf_001

install:
	if [ ! -d /usr/local/cuda-11.0 ]; then sh +x bin/install_cuda110.sh; fi
	conda env update -f environment.yml

cuda:
	sh +x bin/install_cuda110.sh

jax:
	pip install --upgrade jax jaxlib==0.1.65+cuda110 -f https://storage.googleapis.com/jax-releases/jax_releases.html

download-lego: jax
	if [ ! -d "./nerf_synthetic" ]; then gsutil -m cp -r gs://lucas.netdron.es/nerf_synthetic .; fi

train-lego: download-lego
	sh +x scripts/train_blender.sh

eval-lego:
	sh +x scripts/eval_blender.sh

download-picnic: jax
	if [ ! -d ${PICNIC_DIR} ]; then gsutil -m cp -r gs://lucas.netdron.es/${PICNIC_DIR} .; fi

downscale-picnic: download-picnic
	python bin/downscale_images.py

colmap-picnic: downscale-picnic
	colmap feature_extractor \
	  --database_path ${PICNIC_DIR}/database.db \
	  --image_path ${PICNIC_DIR}/images
	colmap exhaustive_matcher \
	  --database_path ${PICNIC_DIR}/database.db
	if [ ! -d ${PICNIC_DIR}/sparse ]; then mkdir -p ${PICNIC_DIR}/sparse; fi
	colmap mapper \
	  --database_path ${PICNIC_DIR}/database.db \
	  --image_path ${PICNIC_DIR}/images \
	  --output_path ${PICNIC_DIR}/sparse

llff-picnic: colmap-picnic
	python LLFF/imgs2poses.py ${PICNIC_DIR}

picnic: llff-picnic
	sh +x scripts/train_picnic.sh

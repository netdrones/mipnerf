.DEFAULT_GOAL := help

PICNIC_DIR = picnic_nerf_001

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, %%2}'

install:
	conda env update -f environment.yml
	pip install --upgrade jax jaxlib==0.1.65+cuda101 -f https://storage.googleapis.com/jax-releases/jax_releases.html

train-lego:
	if [ ! -d "./nerf-data" ]; then gsutil -m cp -r gs://lucas.netdron.es/nerf-data .; fi
	sh +x scripts/train_blender.sh

eval-lego:
	sh +x scripts/eval_blender.sh

download-picnic:
	if [ ! -d ${PICNIC_DIR} ]; then gsutil -m cp -r gs://lucas.netdron.es/${PICNIC_DIR} .; fi

colmap-picnic: download-picnic
	colmap feature_extractor \
	  --database_path ${PICNIC_DIR}/database.db \
	  --image_path ${PICNIC_DIR}/images
	colmap exhaustive_matcher \
	  --database_path ${PICNIC_DIR}/database.db
	mkdir ${PICNIC_DIR}/sparse
	colmap mapper \
	  --database_path ${PICNIC_DIR}/database.db \
	  --image_path ${PICNIC_DIR}/images \
	  --output_path ${PICNIC_DIR}/sparse

llff-picnic: colmap-picnic
	python LLFF/imgs2poses.py ${PICNIC_DIR}

picnic: llff-picnic
	sh +x scripts/train_picnic.sh

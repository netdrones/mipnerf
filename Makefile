.DEFAULT_GOAL := help

install:
	conda env update -f environment.yml
	pip install --upgrade jax jaxlib==0.1.65+cuda101 -f https://storage.googleapis.com/jax-releases/jax_releases.html
	if [ ! -d "./nerf-data" ]; then gsutil -m cp -r gs://lucas.netdron.es/nerf-data .; fi
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, %%2}'

.PHONY: all

CURDIR := $(shell pwd)

help: ## Print this help
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build: ## Build containers
	docker build -t ryutah/elasticsearch -f Dockerfile.elasticsearch .
	docker build -t ryutah/kibana -f Dockerfile.kibana .

loads_accounts_dataset: ## Loading sample dataset of account
	curl -X POST \
	  -H "Content-Type: application/json" \
	  --data-binary "@dataset/accounts.json" \
	  "http://${ELASTIC_SEARCH_HOST}/bank/_doc/_bulk?pretty&refresh"

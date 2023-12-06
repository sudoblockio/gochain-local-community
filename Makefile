.DEFAULT_GOAL := help

WALLET_NAME ?= keystore.json
WALLET_PASSWORD ?= gochain
GOD_WALLET_PATH ?= icon-chain/config/keystore.json
GOD_WALLET_PASSWORD ?= gochain

clone-dependencies:  ## Clone all the dependencies
	git clone https://github.com/sudoblockio/icon-tracker-frontend
	git clone https://github.com/icon-project/goloop

up-stack:  ## Bring up the stack
	docker-compose \
	-f docker-compose.yml \
	-f docker-compose.icon-chain.yml \
	-f docker-compose.nginx.yml \
	-f docker-compose.frontend.yml \
	up -d

down-stack:  ## Bring down the stack without deleting volumes
	docker-compose \
	-f docker-compose.yml \
	-f docker-compose.icon-chain.yml \
	-f docker-compose.nginx.yml \
	-f docker-compose.frontend.yml \
	down

enable-debug:
	@docker-compose -f docker-compose.icon-chain.yml exec -T icon goloop system config rpcIncludeDebug true

install-goloop:  ## Install goloop
	cd goloop && $(MAKE) goloop

create-wallet:  ## Create a wallet with goloop
	@if [ -f $(WALLET_NAME) ]; then \
		echo "File $(WALLET_NAME) already exists. Exiting."; \
		exit 1; \
	fi
	./goloop/bin/goloop ks gen -o ${WALLET_NAME} -p ${WALLET_PASSWORD}

fund-wallet:  ## Fund the keystore
	@$(eval ADDRESS=$(shell jq -r '.address' $(WALLET_NAME)))
	@echo "Sending transaction to address $(ADDRESS)"
	./goloop/bin/goloop rpc sendtx transfer --uri "http://localhost:9080/api/v3" --nid "3" --step_limit "2000000" --to $(ADDRESS) --value "1000000000000000000000" --key_password $(GOD_WALLET_PASSWORD) --key_store ${GOD_WALLET_PATH}

clean:  ## Delete the state of the chain
	echo "Starting cleaning..."
	rm -rf icon-chain/data
	rm -rf icon-chain/data
	echo "Cleaned up..."

wait-for-stack:
	bash scripts/wait-for-stack.sh

all: clone-dependencies install-goloop up-stack wait-for-stack enable-debug create-wallet fund-wallet  ## All the things

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'

-include .env

build:; forge build
deploy_sapolia: 
	forge script script/DeployFundMe.s.sol:DeployFundMe -- --RPC-URL $(SAPOLIA_RUC_URL) --private-key $(METAMASK_PRIVATE_KEY) --broadcast --verify --etherscan-api-key $($ETHERSCAN_API_KEY) -vvvv

install_foundry=curl -L https://foundry.paradigm.xyz | bash

//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;
import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/mockV3Aggregator.sol";

    contract helperConfig is Script{

        getSap public getSapActive;
        uint8 public constant decimals = 8;
        int256 public constant initial_price = 2000e8;
        struct  getSap {
            address priceFeed ;//ETH/USD priceConverter

            
        }
        constructor() {
            if (block.chainid == 11155111) {
                getSapActive = getsepoliaETHConfig();
            } else if (block.chainid == 1) {
                getSapActive = getmainnetETHConfig();
            } else {
                getSapActive = getAnvilETHconfig();
            }
        }

        function getsepoliaETHConfig() public pure returns (getSap memory) {
            getSap memory getNewSap = getSap ({priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306});

            return  getNewSap;

        }
        
       
        function getmainnetETHConfig() public pure returns (getSap memory) {
            getSap memory getmainnet = getSap ({priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419});

            return  getmainnet;

        }
        function getAnvilETHconfig() public returns (getSap memory) {
            if (getSapActive.priceFeed != address(0)) {
                return getSapActive;
            }

            //1. deploy the mocks(not that mock contracts are dumy contract)
            vm.startBroadcast();
            MockV3Aggregator MockPriceFeed = new MockV3Aggregator(decimals, initial_price);
             vm.stopBroadcast();

             getSap memory getNewAnvil = getSap ({priceFeed: address(MockPriceFeed)});

             return getNewAnvil;

        }
}


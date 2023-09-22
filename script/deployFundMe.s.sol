//SPDX-Licnense-Identifier: MIT
import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {helperConfig} from "./helperconfigure.s.sol";

pragma solidity ^0.8.18 ;
contract DeployFundMe is Script{
    
    function run() external returns(FundMe){
        helperConfig HelperConfig = new helperConfig();
        address ethUsdPriceFeed = HelperConfig.getSapActive();
        vm.startBroadcast();
        
        FundMe fundMe = new FundMe(ethUsdPriceFeed);
        vm.stopBroadcast();
        return fundMe;
    
    }

} 
//SPDX-License-Identifier: MIT


pragma solidity 0.8.19;
import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundME is Script {
    uint public constant SEND_VALUE = 0.01 ether;

    function fundFundME(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        
        FundMe(payable(mostRecentlyDeployed)).fund{value: SEND_VALUE}();
        vm.stopBroadcast();
        
        // console.log("funded fundME with us", SEND_VALUE);
    }

    function run() external {

        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        vm.startBroadcast();
        fundFundME(mostRecentlyDeployed);
        vm.stopBroadcast();
    }

}



contract WithdrawFundMe is Script{
    function withdrawFundME(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).withdraw();
        vm.stopBroadcast();
        
        // console.log("funded fundME with us", SEND_VALUE);
    }

    function run() external {

        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        vm.startBroadcast();
        withdrawFundME(mostRecentlyDeployed);
        vm.stopBroadcast();
    }

}



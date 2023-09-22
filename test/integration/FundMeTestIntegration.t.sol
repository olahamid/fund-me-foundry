//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/deployFundMe.s.sol";
import {FundFundME} from "../../script/interaction.s.sol";
import { WithdrawFundMe} from "../../script/interaction.s.sol";


contract FundMeTestInteraction is Test {

    FundMe fundMe;
    address USER = makeAddr("user");
    uint constant send_value = 0.1 ether;
    uint constant starting_value = 10 ether;
    uint constant GAS_PRICE = 1;
    function setUp() external {
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, starting_value);
    }
    function testUsserCanFundInteraction() public {
        FundFundME fundFundME =  new FundFundME();
        // vm.prank(USER);
        // vm.deal(USER, 1e18);
        fundFundME.fundFundME(address(fundMe));
        WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        withdrawFundMe.withdrawFundME(address(fundMe));

        assert(address(fundMe).balance == 0);

    //     address funder = fundMe.getFunder(0);
    //     assertEq(funder,USER );
    // }

}
}
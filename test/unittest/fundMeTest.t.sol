//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/deployFundMe.s.sol";


contract fundMeTest is Test {
    FundMe fundMe;
    address USER = makeAddr("user");
    uint constant send_value = 0.1 ether;
    uint constant starting_value = 10 ether;
    uint constant GAS_PRICE = 1;

    function setUp() external {
        // fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306) ;
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, starting_value);
    }
    function testMindollarisffive() public {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
        
    }
    function testownerismsgsender() public {
        assertEq(fundMe.i_owner(), msg.sender);


    }
    function getversiontest() public {
        uint version = fundMe.getVersion();
        assertEq(version, 4);
    }
    // function testingfund() public  {
    //     assertEq(fundMe.fund(),msg.sender);
        
    // }
    function testFundfailwithoutenoughETH() public {
        vm.expectRevert();
        fundMe.fund();
    }
    //good the require statement we are testing if the funding fails without enough ETH being tested
    function testupdatedatastructure() public  {
        vm.prank(USER); //the next tx wiill be sent by the user
        // vm.expectRevert();
        fundMe.fund{value: send_value}();
        //this is a prank functiion to check which address is calling a particular function, you will also use make addr
        

        uint256 amountfunded = fundMe.getaddressToAmountFunded(USER);
        assertEq(amountfunded, send_value);
        
    }
    function testAddsFunderToArrayofFunders() public {
        vm.prank(USER);
        fundMe.fund{value: send_value}();
        address funder = fundMe.getFunder(0);
        assertEq(funder, USER);

    }
    modifier funded() {
        vm.prank(USER);
        fundMe.fund{value: send_value}();
        _;
    }
    function hasOnlyOwner() public funded {
        
        
        vm.prank(USER);
        vm.expectRevert();
        
        fundMe.withdraw();
    }
    function testWithdrawFromASingleFunder() public funded {
        // Arrange
        uint256 startingFundMeBalance = address(fundMe).balance;
        uint256 startingOwnerBalance = fundMe.getOwner().balance;

        // vm.txGasPrice(GAS_PRICE);
        // uint256 gasStart = gasleft();
        // // Act
        vm.startPrank(fundMe.getOwner());
        fundMe.withdraw();
        vm.stopPrank();

        // uint256 gasEnd = gasleft();
        // uint256 gasUsed = (gasStart - gasEnd) * tx.gasprice;

        // Assert
        uint256 endingFundMeBalance = address(fundMe).balance;
        uint256 endingOwnerBalance = fundMe.getOwner().balance;
        assertEq(endingFundMeBalance, 0);
        assertEq(
            startingFundMeBalance + startingOwnerBalance,
            endingOwnerBalance // + gasUsed
        );
    }
    // function testWithDrawFromMultipleFunders() public funded {
    //     uint160 numberOfFunders = 10;
    //     uint160 startingFunderIndex = 2;
    //     for (uint160 i = startingFunderIndex; i < numberOfFunders + startingFunderIndex; i++) {
    //         // we get hoax from stdcheats
    //         // prank + deal
    //         hoax(address(i), STARTING_USER_BALANCE);
    //         fundMe.fund{value: SEND_VALUE}();
    //     }

    //     uint256 startingFundMeBalance = address(fundMe).balance;
    //     uint256 startingOwnerBalance = fundMe.getOwner().balance;

    //     vm.startPrank(fundMe.getOwner());
    //     fundMe.withdraw();
    //     vm.stopPrank();

    //     assert(address(fundMe).balance == 0);
    //     assert(startingFundMeBalance + startingOwnerBalance == fundMe.getOwner().balance);
    //     assert((numberOfFunders + 1) * SEND_VALUE == fundMe.getOwner().balance - startingOwnerBalance);
    // }
}
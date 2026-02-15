// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;
import {Test, console} from "lib/forge-std/src/Test.sol";
import {fundme} from "../src/fundme.sol";
import {deployfundme} from "../script/deployfundme.s.sol";

contract fundmetest is Test{
    fundme Fundme;
    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;

    function setUp() external {
        //  Fundme = new fundme(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        deployfundme Deployfundme = new deployfundme();
        Fundme = Deployfundme.run();
        vm.deal(USER, STARTING_BALANCE);

    }

    
    function testingamount() public view {
        assertEq(Fundme.MINIMUM_USD(), 5e18);
    }
    function testowner() public view{
        assertEq(Fundme.i_owner(), msg.sender);
    }

    function testpricefeedversionisaccurate() public view{
        uint256 version = Fundme.getVersion();
        assertEq(version, 4);
    }

    function testfundsfailwithoutenoguheth() public {
        vm.expectRevert();
        Fundme.fund();
    }

    function testfundupdatesfundeddatastructure() public {
        vm.prank(USER);

        Fundme.fund{value: SEND_VALUE}();
        uint256 amountfunded = Fundme.getaddresstoamountfunded(USER);
        assertEq(amountfunded, SEND_VALUE);
    }
    
}
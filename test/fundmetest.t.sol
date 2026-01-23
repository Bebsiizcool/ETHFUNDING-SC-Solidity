// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;
import {Test, console} from "lib/forge-std/src/Test.sol";
import {fundme} from "../src/fundme.sol";
import {deployfundme} from "../script/deployfundme.s.sol";

contract fundmetest is Test{
    fundme Fundme;
    function setUp() external {
        //  Fundme = new fundme(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        deployfundme Deployfundme = new deployfundme();
        Fundme = Deployfundme.run();
    }

    
    function testingamount() public view {
        assertEq(Fundme.MINIMUM_USD(), 5e18);
    }
    function testowner() public view{
        assertEq(Fundme.i_owner(), msg.sender);
    }

    // function testpriceconversion() public {
    //     uint256 version = Fundme.get;
    // }
    
}
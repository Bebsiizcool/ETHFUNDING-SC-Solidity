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
    uint256 constant GAS_PRICE = 1;

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
        assertEq(Fundme.getowner(), msg.sender);
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

    function addfundertoarray() public{
        vm.prank(USER);
        Fundme.fund{value: SEND_VALUE}();
        address funder = Fundme.getfunder(0);
        assertEq(funder, USER);
    }


    modifier funded(){
        vm.prank(USER);
        Fundme.fund{value: SEND_VALUE}();
        _;
    }


    function testonlyownercanwithdraw() public funded{
        
        vm.expectRevert();
        vm.prank(USER);
        Fundme.withdraw();
    }

    function testwithdraw() public funded{
        uint256 startingfundmebalance = address(Fundme).balance;
        uint256 startingownerbalance = Fundme.getowner().balance;

        vm.startPrank(Fundme.getowner());
        Fundme.withdraw();
        vm.stopPrank();

        uint256 endingfundmebalance = address(Fundme).balance;
        uint256 endingownerbalance = Fundme.getowner().balance;
        assertEq(endingfundmebalance, 0);
        assertEq(startingownerbalance + startingfundmebalance, endingownerbalance);
        
    }

    function withdrawmultiplefunders () public funded{
        uint160 numberoffunders = 10;
        uint160 startingfunderindex = 1;

        for (uint160 i = startingfunderindex; i<numberoffunders; i++){
            hoax(address(i), SEND_VALUE);
            Fundme.fund{value:SEND_VALUE}();
        }

        uint256 endingownerbalance = Fundme.getowner().balance;
        uint256 endingfundmeblance = address(Fundme).balance;

        vm.startPrank((Fundme.getowner()));
        Fundme.withdraw();
        vm.stopPrank();

        assertEq(address(Fundme).balance, 0);
        assertEq(endingownerbalance + endingfundmeblance, Fundme.getowner().balance);
    }

    function cheaperwithdrawmultiplefunders() public funded{
        uint160 numberoffunders = 10;
        uint160 startingfunderindex = 1;

        for (uint160 i = startingfunderindex; i<numberoffunders; i++){
            hoax(address(i), SEND_VALUE);
            Fundme.fund{value:SEND_VALUE}();
        }

        uint256 startingownerbalance = Fundme.getowner().balance;
        uint256 startingfundmebalance = address(Fundme).balance;

        vm.startPrank((Fundme.getowner()));
        Fundme.cheaperwithdraw();
        vm.stopPrank();

        assert(address(Fundme).balance == 0);
        assert(startingownerbalance + startingfundmebalance == Fundme.getowner().balance);
    }
    
}
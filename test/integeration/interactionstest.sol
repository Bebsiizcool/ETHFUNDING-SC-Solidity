// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;
import {Test, console} from "lib/forge-std/src/Test.sol";
import {fundme} from "../../src/fundme.sol";
import {deployfundme} from "../../script/deployfundme.s.sol";
import {interactions, WithdrawFundme} from "../../script/interactions.s.sol";

contract interactionstest is Test{

        fundme Fundme;
    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;
    uint256 constant GAS_PRICE = 1;

    function setUp() external {
        deployfundme Deployfundme = new deployfundme();
        Fundme = Deployfundme.run();
        vm.deal(USER, STARTING_BALANCE);
    }

    function testusercanfund() public {
        interactions FundFundMe = new interactions();
        FundFundMe.fundfundme(address(Fundme));

        WithdrawFundme WithdrawFundMe = new WithdrawFundme();
        WithdrawFundMe.withdrawfundme(address(Fundme));

        assert(address(Fundme).balance == 0);
    }
}
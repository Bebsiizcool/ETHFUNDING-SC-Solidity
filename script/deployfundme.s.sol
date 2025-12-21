// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Script} from "lib/forge-std/src/Script.sol";
import {fundme} from "../src/fundme.sol";

contract deployfundme is Script{
    function run() external returns (fundme){
        vm.startBroadcast();
        fundme Fundme = new fundme(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        vm.stopBroadcast();
        return Fundme;
    }
}
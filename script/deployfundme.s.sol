// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Script} from "lib/forge-std/src/Script.sol";
import {fundme} from "../src/fundme.sol";
import {helperconfig} from "./helperconfig.s.sol";

contract deployfundme is Script{
    
    function run() external returns (fundme){

        helperconfig Helperconfig = new helperconfig();
        address pricefeed = Helperconfig.activeNetworkConfig();

        vm.startBroadcast();
        fundme Fundme = new fundme(pricefeed);
        vm.stopBroadcast();
        return Fundme;
    }
}
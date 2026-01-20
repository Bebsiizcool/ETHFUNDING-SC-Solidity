// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Script} from "forge-std/Script.sol";


contract helperconfig is Script{

    networkconfig public activeNetworkConfig;
    struct networkconfig{
        address pricefeed;
    }

    constructor() {
        if(block.chainid == 11155111){
            activeNetworkConfig = getsepoliaeth();
        } else {
            activeNetworkConfig = getanvileth();
        }
    }

    function getsepoliaeth() public pure returns(networkconfig memory){
        networkconfig memory sepoliaeth = networkconfig({pricefeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306});
        return sepoliaeth;
    }

    function getanvileth() public pure returns(networkconfig memory){

    }
}
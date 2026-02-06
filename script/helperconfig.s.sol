// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Aggregator.sol";


contract helperconfig is Script{

    networkconfig public activeNetworkConfig;
    uint8 public constant decimals = 8;
    int256 public constant INTIAL_PRICE = 2000e8;

    struct networkconfig{
        address pricefeed;
    }

    constructor() {
        if(block.chainid == 11155111){
            activeNetworkConfig = getsepoliaeth();
        } 
        else if(block.chainid == 1){
            activeNetworkConfig = getmainneteth();
        }

        else {
            activeNetworkConfig = getanvileth();
        }
    }

    function getsepoliaeth() public pure returns(networkconfig memory){
        networkconfig memory sepoliaeth = networkconfig({pricefeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306});
        return sepoliaeth;
    }

      function getmainneteth() public pure returns(networkconfig memory){
        networkconfig memory ethconfig = networkconfig({pricefeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419});
        return ethconfig;
    }

    function getanvileth() public returns(networkconfig memory){

        if(activeNetworkConfig.pricefeed != address(0)){
            return activeNetworkConfig;
        }
        vm.startBroadcast();
        MockV3Aggregator mockpricefeed = new MockV3Aggregator(decimals, INTIAL_PRICE);
        vm.stopBroadcast();
        networkconfig memory anvileth = networkconfig({pricefeed: address(mockpricefeed)});
        return anvileth;
    }
        
    
}
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;
import {Script, console} from "lib/forge-std/src/Script.sol";
import {fundme} from "../src/fundme.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract interactions is Script{

    uint256 constant SEND_VALUE = 0.1 ether;

    function fundfundme(address mostRecentlyDeployed) public{
        vm.startBroadcast();
        fundme (payable(mostRecentlyDeployed)).fund{value: SEND_VALUE}();
        vm.stopBroadcast();
        console.log("Funded fundme with %s", SEND_VALUE);
    }

    function run() external{
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("fundme", block.chainid);
        fundfundme(mostRecentlyDeployed);
        
    }
}

contract WithdrawFundme is Script{
    function withdrawfundme(address mostRecentlyDeployed) public{
        vm.startBroadcast();
        fundme(payable(mostRecentlyDeployed)).withdraw();
        vm.stopBroadcast();
        console.log("Withdrew from fundme");
    }

    function run() external{
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("fundme", block.chainid);
     
        withdrawfundme(mostRecentlyDeployed);
      
    }
}
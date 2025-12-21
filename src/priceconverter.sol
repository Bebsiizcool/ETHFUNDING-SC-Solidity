// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;
import "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol"; 
// import "./AggregatorV3Interface.sol";

library priceconverter{
      function getprice(AggregatorV3Interface priceFeed) internal view returns (uint256) {
        // 0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF zksycn sepolia 
        
        (,int256 price,,,) = priceFeed.latestRoundData();
        return uint256(price * 1e10);
    }

    function getconversionrate(uint256 ethamount, AggregatorV3Interface priceFeed) internal view returns(uint256) {
        uint256 ethprice = getprice(priceFeed);
        uint256 ethamountinusd = (ethprice * ethamount) / 1e18;
        return ethamountinusd;
    }

    function getversion() public view returns (uint256){
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }
}
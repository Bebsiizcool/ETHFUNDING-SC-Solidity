// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;
// import "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol"; you can also import aggregator direct from their github
import "./AggregatorV3Interface.sol";

library priceconverter{
      function getprice() internal view returns (uint256) {
        // 0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF zksycn sepolia 
        AggregatorV3Interface pricefeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 price,,,) = pricefeed.latestRoundData();
        return uint256(price * 1e10);
    }

    function getconversionrate(uint256 ethamount) internal view returns(uint256) {
        uint256 ethprice = getprice();
        uint256 ethamountinusd = (ethprice * ethamount) / 1e18;
        return ethamountinusd;
    }

    function getversion() public view returns (uint256){
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }
}

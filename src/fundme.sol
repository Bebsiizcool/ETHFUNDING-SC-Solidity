// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;
import "./priceconverter.sol";

contract fundme{
    using priceconverter for uint256;
    uint256 public constant MINIMUM_USD = 5e18;

    address[] private s_funders;
    mapping(address => uint256) private s_addresstoamount;


    address private immutable i_owner;
    AggregatorV3Interface public s_priceFeed;

    constructor(address priceFeed){
        i_owner = msg.sender;
        s_priceFeed = AggregatorV3Interface(priceFeed);
    }

    function fund() public payable{
        
        require(msg.value.getconversionrate(s_priceFeed) >= MINIMUM_USD, "didnt send enough eth");
        s_funders.push(msg.sender);
        s_addresstoamount[msg.sender] += msg.value;
    }

    function getVersion() public view returns (uint256) {
        return s_priceFeed.version();
    }
    
    function withdraw() public onlyowner{
        
        for(uint256 funderindex = 0; funderindex < s_funders.length; funderindex++){
            address funder = s_funders[funderindex];
            s_addresstoamount[funder] = 0;
        }
        s_funders = new address[] (0);

        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "call failed");
    }

    modifier onlyowner {
        require(msg.sender == i_owner, "you're not the owner");
        _;
    }
   
    receive() external payable{
        fund();
    }

    fallback() external payable{
        fund();
    }

    // view/pure functions 

    function getaddresstoamountfunded( address fundingaddress) external view returns (uint256){
        return s_addresstoamount[fundingaddress];
    }

    function getfunder(uint256 index ) external view returns(address) {
        return s_funders[index];
    }

    function getowner() external view returns (address){
        return i_owner;
    }
}


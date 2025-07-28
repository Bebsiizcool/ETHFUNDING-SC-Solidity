// SPDX-License-Identifier: MIT

pragma solidity 0.8.30;
import "./priceconverter.sol";

contract fundme{
    using priceconverter for uint256;
    uint256 public constant MINIMUM_USD = 5e18;

    address[] public funders;
    mapping(address => uint256) public addresstoamount;
    address public immutable i_owner;
    constructor(){
        i_owner = msg.sender;
    }

    function fund() public payable{
        
        require(msg.value.getconversionrate() >= MINIMUM_USD, "didnt send enough eth");
        funders.push(msg.sender);
        addresstoamount[msg.sender] += msg.value;
    }
    function withdraw() public onlyowner{
        
        for(uint256 funderindex = 0; funderindex < funders.length; funderindex++){
            address funder = funders[funderindex];
            addresstoamount[funder] = 0;
        }
        funders = new address[] (0);

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
}



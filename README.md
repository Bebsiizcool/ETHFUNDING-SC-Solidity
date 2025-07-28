# FundMe DApp

This is a beginner-level Ethereum smart contract written in Solidity that allows users to fund a contract with ETH, and withdraw only if they are the contract owner. The contract ensures that users send a **minimum amount of ETH worth at least $5 USD**, using live ETH/USD data fetched from Chainlink price feeds.

## 🧱 Smart Contracts

There are two main contracts in this project:

### 1. `fundme.sol`
- Main contract for accepting and withdrawing ETH.
- Uses a `priceconverter` library to check minimum USD value.
- Includes fallback and receive functions to handle direct ETH transfers.
- Restricts withdrawals to only the owner of the contract.

### 2. `priceconverter.sol`
- A Solidity library that fetches live ETH/USD prices using Chainlink’s AggregatorV3Interface.
- Includes utility functions for price retrieval and ETH to USD conversion.

## 📦 Features

- Uses Chainlink price oracles on Sepolia testnet.
- Validates minimum funding in USD.
- Owner-only withdrawal functionality.
- Fallback and receive functions for direct ETH payments.

## 🔗 Deployed on (Example)

Sepolia Testnet  
Price Feed Used: [0x694AA1769357215DE4FAC081bf1f309aDC325306](https://sepolia.etherscan.io/address/0x694AA1769357215DE4FAC081bf1f309aDC325306)

## 🛠️ Tech Stack

- Solidity `^0.8.30`
- Chainlink Oracles
- OpenZeppelin (optional, for upgrades and security)
- Hardhat or Remix (for testing/deploying)

## 🧪 How to Use

1. Clone the repository.
2. Compile the contracts in Remix or Hardhat.
3. Deploy to Sepolia (or another testnet).
4. Interact with the `fund` and `withdraw` functions.
5. Make sure to have testnet ETH and the correct Chainlink price feed address.

## 📚 License

MIT

---

### ✨ Credits

This contract was written as a learning project to understand Chainlink price feeds, payable functions, Solidity libraries, and contract security best practices.

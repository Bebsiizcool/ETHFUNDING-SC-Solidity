# Codebase Explanation

Here is a simple explanation of the files in this repository, broken down by folder.

## 📂 src (Source Code)
This folder contains the actual smart contracts—the code that gets deployed to the blockchain.

### `fundme.sol` (The Piggy Bank)
This is the main contract. Think of it as a **digital crowdfunding wallet**.
- **What it does:**
  - Allows people to send ETH (money) to it.
  - Checks if the amount sent is worth at least **$5 USD**.
  - Keeps a list of everyone who donated (`funders`).
  - Allows **only the owner** (the person who deployed it) to withdraw all the money.

### `priceconverter.sol` (The Calculator)
This is a "library" (a helper file). It doesn't hold money; it just does math.
- **What it does:**
  - It talks to an external service (Chainlink Oracle) to get the current price of Ethereum in USD.
  - It converts the ETH amount sent by a user into its USD equivalent to check if it meets the $5 minimum.

---

## 📂 script (Automation)
This folder contains scripts to automate tasks, like putting your contract on the blockchain.

### `deployfundme.s.sol` (The Deployer)
This script actually puts your `fundme` contract onto the network.
- **What it does:**
  - It looks at `helperconfig` to get the correct settings.
  - It "broadcasts" the transaction to create the `fundme` contract.

### `helperconfig.s.sol` (The Network Manager)
This script makes sure your code works on different networks without changing the main code.
- **What it does:**
  - If you are on **Sepolia** (testnet), it gives you the Sepolia price feed address.
  - If you are on **Mainnet** (real Ethereum), it gives you the Mainnet price feed address.
  - If you are on **Anvil** (local computer), it creates a "fake" price feed so you can test without internet.

---

## 📂 test (Quality Control)
This folder contains tests to make sure your code does what it's supposed to do.

### `fundmetest.t.sol` (The Inspector)
This file runs automatic checks on your contract.
- **What it does:**
  - It deploys a fresh version of `fundme` before every test.
  - It checks things like:
    - "Is the minimum USD set to 5?"
    - "Is the owner strictly the person who deployed it?"
  - If any check fails, it alerts you so you can fix bugs before deploying.

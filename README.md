# ETHFUNDING‑SC‑Solidity

A **decentralized funding smart contract** built in **Solidity** that enables users to send ETH to the contract, enforcing a **minimum USD contribution** using real‑time price data from Chainlink oracles. This project uses **Foundry** for compilation, testing, and scripting.

---

## 🧠 Overview

This repository contains a Solidity smart contract designed to:

✔ Accept ETH contributions from users  
✔ Ensure a minimum contribution equivalent in USD using Chainlink price feeds  
✔ Allow only the contract owner to withdraw collected funds  
✔ Track funders and contributions for transparency

This type of contract is commonly used for crowdfunding, fundraising, or community support initiatives on the Ethereum blockchain. :contentReference[oaicite:1]{index=1}

---

## 🚀 Features

- **Fund with ETH** — Users can send ETH to the contract.
- **USD equivalent enforcement** — Contributions must meet a minimum USD amount.
- **Price conversion via Chainlink** — Real‑time ETH/USD price feed integration.
- **Owner‑only withdrawal** — Only the deployer can withdraw funds.
- **Tested locally with Foundry** — Fast local tests and scripts included.

---

## 🧩 Tech Stack

| Component | Purpose |
|-----------|---------|
| Solidity | Smart contract language |
| Chainlink Oracles | Price feed for ETH ↔ USD conversion |
| Foundry | Build, test, and script automation |
| Anvil | Local Ethereum node for testing |

---

## 📦 Getting Started

Clone the repository:

```bash
git clone https://github.com/Bebsiizcool/ETHFUNDING-SC-Solidity.git
cd ETHFUNDING-SC-Solidity

# 🔐 Smart Contracts - Clarichain

This repo contains the Plutus smart contracts for Clarichain, built on the **Cardano** blockchain.

---

## ⚙️ Tech Stack
- **Blockchain**: Cardano
- **Smart Contract Language**: Plutus (Haskell)
- **Tools**:
  - [`plutus-apps`](https://github.com/input-output-hk/plutus-apps)
  - [`cardano-cli`](https://github.com/input-output-hk/cardano-node)
  - [`plutip`](https://github.com/Plutonomicon/plutip) for local testing
  - [`Aiken`](https://aiken-lang.org/) (optional, if you're using it)

---

## 🚀 Getting Started

### 1. Clone Repo
```bash
git clone https://github.com/clarichain/smart-contract.git
cd smart-contract
```
## 2. Set Up Plutus Environment
You can use the `plutus-starter` or `Plutus Playground`.
If using `nix`:

```bash
nix-shell
cabal update
cabal build
```

If using `Docker` (optional):

```bash
docker-compose up
```

##🧪 Running Tests
If using `Plutip` or `emulator`:

```bash
cabal test
```
If using Aiken:

```bash
aiken test
```

## 📁 Project Structure
```bash
📦 smart-contract/
├── src/              # Smart contracts (Plutus scripts)
├── test/             # Tests and simulations
├── scripts/          # Deployment scripts (cardano-cli, plutip)
├── assets/           # Policy IDs, compiled scripts
├── README.md
└── ...
```
## 📄 Deployment (Local or Testnet)
Example with `cardano-cli`:
```bash
cardano-cli transaction build \
  --alonzo-era \
  --testnet-magic 1097911063 \
  --tx-in ... \
  --tx-out ... \
  --change-address ... \
  --out-file tx.raw
  ```
Use `cardano-wallet` or `blockfrost API` for easier integration.

## 🧠 Contribution
See [CONTRIBUTING.md](CONTRIBUTING.md) for branch naming, PR rules, and code style.
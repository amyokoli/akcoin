# Akcoin

Akcoin is a minimal token-style contract implemented as a [Clarity](https://docs.stacks.co/write-smart-contracts/language-overview)
smart contract and managed with [Clarinet](https://github.com/hirosystems/clarinet).

This project was bootstrapped with `clarinet new .` and contains a single contract, `akcoin`,
which tracks a configurable total supply of Akcoin (`AKC`) under the control of the contract owner.

## Project structure

- `Clarinet.toml` – Clarinet project configuration and contract registration.
- `contracts/akcoin.clar` – Akcoin token contract implementation.
- `settings/` – network configuration for Devnet, Testnet, and Mainnet.
- `tests/` – Vitest-based TypeScript tests (currently containing an example test file).
- `.vscode/` – VS Code tasks and settings for working with Clarinet.

## Contract overview

The `akcoin` contract exposes a very small API:

- **Metadata**
  - `get-name` → `(optional (string-ascii 32))` – returns `"Akcoin"`.
  - `get-symbol` → `(optional (string-ascii 8))` – returns `"AKC"`.
  - `get-decimals` → `uint` – returns `u6`.

- **Ownership & supply**
  - `get-owner` → `principal` – the deployer of the contract. Only this principal can modify supply.
  - `get-total-supply` → `uint` – current configured total supply of AKC.

- **State-changing functions**
  - `set-total-supply (amount uint)` → `(response bool uint)`
    - Sets `total-supply` to `amount`.
    - Fails with error code `u100` (unauthorized) if caller is not the owner.

### Error codes

- `u100` – `ERR_UNAUTHORIZED`: caller is not allowed to perform the requested action
  (for example, trying to change the total supply when not the owner).

## Getting started

Make sure you have Clarinet installed and available on your `PATH`:

```sh
clarinet --version
```

From the project root (`akcoin`):

```sh
clarinet check
```

This command runs the Clarity analyzer on all contracts in `contracts/` and ensures the
project compiles and passes static checks.

## Running tests

This project was scaffolded with a Vitest-based TypeScript testing setup. To install the
JavaScript dependencies and run tests:

```sh
npm install
npm test
```

You can add new tests to files under the `tests/` directory. To call functions on the
`akcoin` contract from tests, use the Clarinet JS test harness, for example:

```ts
const accounts = simnet.getAccounts();
const deployer = accounts.get("deployer")!;

const { result } = simnet.callPublicFn(
  "akcoin",
  "set-total-supply",
  [types.uint(1000)],
  deployer,
);
```

Refer to the official Clarinet JS SDK documentation for more detailed examples and
best practices: https://docs.hiro.so/stacks/clarinet-js-sdk

## Verification

Whenever you modify the contract, re-run:

```sh
clarinet check
```

This ensures the contract remains syntactically and semantically valid before you
deploy it or integrate it into other applications.

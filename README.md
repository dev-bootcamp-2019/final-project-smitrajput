# BountyDapp

## What it is?

A decentralized application that allows one and all to post bounties on any task they wish, and solve them at the will of the bounty-creators to get paid out in ETH.

## Key Features

1. Allows one to create bounties on any task
2. Allows one to solve any bounty and get paid in ETH

## How to set up?

Type the following in the command line / terminal

1. `git clone https://github.com/dev-bootcamp-2019/final-project-smitrajput.git`
2. `cd final-project-smitrajput`
3. To install dapp dependencies: `npm install`
4. To run a local blockchain: `ganache-cli`
5. Copy and save the mnemonic provided by ganache-cli
6. To compile the smart contracts: `truffle compile`
7. To migrate the contracts on the blockchain: `truffle migrate`. Use `truffle migrate --reset` if migrating more than once.
8. `cd client`
9. To install app dependencies: `npm install`
10. To start the local dev server: `npm run start`
11. Visit `http://localhost:3000/` to interact with the dapp

# BountyDapp (WIP)

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

## Testing the contracts locally

1. To run a local blockchain to test the contracts: `truffle develop`
2. To compile, in the truffle console type: `compile`
3. To migrate the contracts on the blockchain: `migrate`. Use `migrate --reset` in case of error.
4. To test, type: `test`

## Testing and Launching the dev server

1. `cd client`
2. To install app dependencies: `npm install`
3. To start the local dev server and launch the dapp: `npm run start`
4. It will aotomatically open, else visit `http://localhost:3000/` to interact with the dapp.
    Type `Y`, if it asks to use another port, in case the port 3000 is already in use.
5. Login to your Metamask into the Rinkeby Test Network and allow the React App to connect to your MetaMask account.
6. Click on 'Become a Bounty-Creator' button to register yourself as a Bounty-Creator.
7. You will observe the number of Bounty-Creators increase (you can cross-check by noting the current number, then refesh the     page, and register again to see the number of Bounty-Creators increase by 1).
8.. You can also see your Metamask account ETH address after registering.

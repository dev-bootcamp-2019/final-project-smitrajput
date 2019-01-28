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
4. To run a local blockchain to test the contracts: `truffle develop`
5. To compile, in the truffle console type: `compile`
6. To migrate the contracts on the blockchain: `migrate`. Use `migrate --reset` in case of error.
7. To test, type: `test`
8. `cd client`
9. To install app dependencies: `npm install`
10. To start the local dev server and launch the dapp: `npm run start`
11. It will aotomatically open, else visit `http://localhost:3000/` to interact with the dapp.
    Type `Y`, if it asks to use another port, in case the port 3000 is already in use.
12. Login to your Metamask and allow the React App to connect to your MetaMask account.
13. Click on 'Become a Bounty-Creator' button to register yourself as a Bounty-Creator.
14. You will observe the number of Bounty-Creators increase (you can cross-check by noting the current number, then refesh the page, and register again to see the number of Bounty-Creators increase by 1).
15. You can also see your Metamask account ETH address after registering.

<p align="center">
  <img src="./client/assets/list.png" align="center" width="150">
</p>

<h1 align="center">BountyDapp</h1>
<p align="center">A decentralized bounty-creating and bounty-hunting application.</p>


### Key Features

1. Allows one to create bounties on any task
2. Allows one to solve any of the listed bounties and get paid in ETH

### Techs and Tools used

1. Truffle v5.0.1
2. Ganache CLI v6.1.6 (ganache-core: 2.1.5)
3. Node v9.11.2
4. ReactJS v16.6.3
5. Semantic-ui-react v0.84.0
6. Semantic-ui-css v2.4.1
7. Web3 v1.0.0-beta.37
8. VS Code v1.31.0
9. Remix

### How to set up?

Type the following in the command line / terminal

1. `git clone https://github.com/dev-bootcamp-2019/final-project-smitrajput.git`
2. `cd final-project-smitrajput`
3. To install dapp dependencies: `npm install`

### Testing the contracts locally

1. To run a local blockchain to test the contracts: `truffle develop`
2. To compile, in the truffle console type: `compile`
3. To migrate the contracts on the blockchain: `migrate`. Use `migrate --reset` in case of error.
4. To test, type: `test`

### Launching the dev server and Dapp interaction

1. `cd client`
2. To install app dependencies: `npm install`
3. To start the local dev server and launch the dapp: `npm run start`
4. It will aotomatically open, else visit `http://localhost:3000/` to interact with the dapp.
    Type `Y`, if it asks to use another port, in case the port 3000 is already in use.
5. Login to your Metamask into the Rinkeby Test Network and allow the React App to connect to your MetaMask account.
6. Click on 'Become a Bounty-Creator' button to register yourself as a Bounty-Creator.
7. You will observe the number of Bounty-Creators increase (you can cross-check by noting the current number, then refesh the     page, and register again to see the number of Bounty-Creators increase by 1).
8. You can also see your Metamask account ETH address after registering.

### Credits

<div>Icons: made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>

README: [Anshuman Verma](https://github.com/anshumanv)


### Author

[Smit Rajput](https://github.com/smitrajput) 

[<img src="https://image.flaticon.com/icons/svg/185/185964.svg" width="35" padding="10">](https://www.linkedin.com/in/smit-r-417517139/)

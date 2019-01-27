import React, { Component } from "react";
import { Button, Menu } from 'semantic-ui-react'
import SimpleStorageContract from "./contracts/SimpleStorage.json";
import getWeb3 from "./utils/getWeb3";

import "./App.css";

class App extends Component {
  state = { storageValue: 0, web3: null, accounts: null, contract: null, activeItem: '' };

  componentDidMount = async () => {
    try {
      // Get network provider and web3 instance.
      const web3 = await getWeb3();

      // Use web3 to get the user's accounts.
      const accounts = await web3.eth.getAccounts();

      // Get the contract instance.
      const networkId = await web3.eth.net.getId();
      const deployedNetwork = SimpleStorageContract.networks[networkId];
      const instance = new web3.eth.Contract(
        SimpleStorageContract.abi,
        deployedNetwork && deployedNetwork.address,
      );

      // Set web3, accounts, and contract to the state, and then proceed with an
      // example of interacting with the contract's methods.
      this.setState({ web3, accounts, contract: instance }, this.runExample);
    } catch (error) {
      // Catch any errors for any of the above operations.
      alert(
        `Failed to load web3, accounts, or contract. Check console for details.`,
      );
      console.error(error);
    }
  };

  runExample = async () => {
    const { accounts, contract } = this.state;

    // Stores a given value, 5 by default.
    await contract.methods.set(5).send({ from: accounts[0] });

    // Get the value from the contract to prove it worked.
    const response = await contract.methods.get().call();

    // Update state with the result.
    this.setState({ storageValue: response, account: accounts[0] });
  };

  handleItemClick = (e, { name }) => this.setState({ activeItem: name });

  // handleClick(event) {
  //   const contract = this.state.contract;
  //   const account = this.state.account;

  //   contract.methods.set.send(3, {from: account})
  //   .then(result => {
  //     return contract.get.call()
  //   }).then(result => {
  //     return this.setState({storageValue: result.c[0]})
  //   })
  // }

  // <Button onClick={this.handleClick.bind(this)}>Set Storage</Button>

  render() {
    if (!this.state.web3) {
      return <div>Loading Web3, accounts, and contract...</div>;
    }

    const { activeItem } = this.state;

    return (
      <div className="App">
        <h1>BountyDapp</h1>
        <div>
          <Button primary>Become a Bounty-Creator</Button>

        </div>

        
          <Menu fluid widths={5}>
            <Menu.Item primary name='Bounty Creators' />
            <Menu.Item name='Address' />
            <Menu.Item name='Number of Bounties created' />
            <Menu.Item name='Total Funding' />
            <Menu.Item name='Solve' />
          </Menu>
          <Menu fluid widths={5}>
            <Menu.Item name='Adam' active={activeItem === 'buy'} onClick={this.handleItemClick} />
            <Menu.Item name='0x03j24u23i4h887HUUHH8h4r35trewerw3' />
            <Menu.Item name='45' />
            <Menu.Item name='4 ETH' />
            <Menu.Item>
              <Button primary>Hunt</Button>
            </Menu.Item>
          </Menu>

          <Menu fluid widths={5}>
            <Menu.Item name='Ramesh' active={activeItem === 'buy'} onClick={this.handleItemClick} />
            <Menu.Item name='0x03j24u23i4h887HUUHH8h4r35trewerw3' />
            <Menu.Item name='34' />
            <Menu.Item name='4 ETH' />
            <Menu.Item>
              <Button primary>Hunt</Button>
            </Menu.Item>
          </Menu>

          <Menu fluid widths={5}>
            <Menu.Item name='Bryan' active={activeItem === 'buy'} onClick={this.handleItemClick} />
            <Menu.Item name='0x03j24u23i4h887HUUHH8h4r35trewerw3' />
            <Menu.Item name='11' />
            <Menu.Item name='4 ETH' />
            <Menu.Item>
              <Button primary>Hunt</Button>
            </Menu.Item>
          </Menu>
      </div>
    );
  }
}

export default App;

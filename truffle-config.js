const path = require("path");
require('dotenv').config();
var HDWalletProvider = require("truffle-hdwallet-provider");
var mnemonic = process.env["NEMONIC"];
var tokenKey = process.env["ENDPOINT_KEY"];

module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  // contracts_build_directory: path.join(__dirname, "client/src/contracts");
  networks: {
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*" // Match any network id
    },
    rinkeby:{
      host: "localhost",
      provider: function() {
        return new HDWalletProvider( mnemonic, "https://rinkeby.infura.io/v3/" + tokenKey);
      },
      network_id:4
      , gas : 6200000
      , gasPrice : 10000000000
    }
  }
};

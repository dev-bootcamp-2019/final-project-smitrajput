var Secure = artifacts.require("../contracts/Secure.sol");
var CreatorFactory = artifacts.require("../contracts/CreatorFactory.sol");
var BountyCreator = artifacts.require("../contracts/BountyCreator.sol");

module.exports = function(deployer, network, accounts) {
  deployer.deploy(Secure);
  deployer.deploy(CreatorFactory);
  deployer.deploy(BountyCreator, "Bob", accounts[1]);
};
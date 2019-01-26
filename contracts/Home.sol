pragma solidity ^0.5.0;

import "./BountyCreator.sol";
import "./Secure.sol";

contract Home is Secure {
    
    BountyCreator[] public deployedCreators;
    uint public numOfCreators;
    
    event CreatorCreated(BountyCreator indexed _newCreator);
    
    constructor() public onlyOwner {}
    
    function createBountyCreator(string memory name) public noEmergency {
        BountyCreator newCreator = new BountyCreator(name, msg.sender);
        deployedCreators.push(newCreator);
        numOfCreators++;
        emit CreatorCreated(newCreator);
    }
    
    function getDeployedCreators() public view returns(BountyCreator[] memory){
        return deployedCreators;
    }
    
}
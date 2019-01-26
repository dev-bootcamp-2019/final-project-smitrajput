pragma solidity ^0.5.0;

import "./BountyCreator.sol";
import "./Secure.sol";

/** @title CreatorFactory 
    @dev Works like a factory to create contracts for bounty-creators
    @author Smit Rajput
*/
contract CreatorFactory is Secure {
    
    /** Storage */
    BountyCreator[] public deployedCreators;
    uint public numOfCreators;
    
    /** Event */
    event CreatorCreated(BountyCreator indexed _newCreator);
    
    /** @dev The contructor to create this contract.
        Allowing only the app-owner to call this contract 
    */
    constructor() public {}
    
    /** @dev Used to create conracts for bounty-creators i.e contracts representing them 
        @param name The name of the bounty-creator
        Only allowed to be called in case of no emergency
    */
    function createBountyCreator(string memory name) public noEmergency {
        BountyCreator newCreator = new BountyCreator(name, msg.sender);
        deployedCreators.push(newCreator);
        numOfCreators++;
        emit CreatorCreated(newCreator);
    }
    
    /** @dev To receive the addresses of deployed contracts representing bounty-creators
        @return deployedCreators An array of type 'BountyCreator' representing addresses of 
        bounty-creators
     */
    function getDeployedCreators() public view returns(BountyCreator[] memory){
        return deployedCreators;
    }
    
}
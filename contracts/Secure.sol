pragma solidity ^0.5.0;

/** @title Secure 
    @dev Used to create a circuit-breaker in case of an emergency
    @author Smit Rajput
*/
contract Secure {
    
    /** Storage */
    address payable constant owner = 0xD14d6F37fF841980f0cFCdF199771ff0D283D880;
    bool public emergencyState = false;
    
    /** Modifiers */
    modifier onlyOwner() {
        require(
            msg.sender == owner, 
            "Only owner can call this function."
        );
        _;
    }
    
    modifier noEmergency() {
        require(
            emergencyState == false,
            "Only allowed to call this function in state of no emergency"
        );
        _;
    }
    
    /** @dev To change the state of emergency from true to false and vice-versa 
        Only the owner has the permission to call this function*/
    function toggleEmergency() public onlyOwner {
        if(emergencyState == false) {
            emergencyState = true;
        } else {
            emergencyState = false;
        }
    }
    
}

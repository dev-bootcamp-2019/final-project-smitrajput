pragma solidity ^0.5.0;

contract Secure {
    
    address payable constant owner = 0xD14d6F37fF841980f0cFCdF199771ff0D283D880;
    bool public emergencyState = false;
    
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
    
    
    function toggleEmergency() public onlyOwner {
        if(emergencyState == false) {
            emergencyState = true;
        } else {
            emergencyState = false;
        }
    }
    
}

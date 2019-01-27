## Common attacks avoided by the smart contract of this dapp

### 1. Reentrancy
The only function that releases payments from the contract is the 'acceptSubmission()' function in the 'BountyCreator.sol' contract.
The following recommended pattern is used in the function to avoid reentrancy.
1. Check for necessary conditions
2. Make internal contract state changes
3. Use 'transfer()' to send the ETH to its destination.

### 2. Force sending ether via selfdestruct
The 'selfdestruct()' method is called only in the 'kill()' method in 'BountyCreator.sol' to remove the bounty-creators who have left
the platform. This method's access to restricted to only the owner of the dapp, i.e the address which deployed the dapp. Hence, it
cannot be forcefully called by a bad actor, so as to transfer the ETH to a target address.

### 3. Integer Overflow
In the 'acceptSubmission()' method in 'BountyCreator.sol', the condition 
        `require(
            theBounty.reward > 0 &&
            theBounty.state == BountyState.Active &&
            theBounty.submissions[subID].author.balance + theReward
            >= theBounty.submissions[subID].author.balance
        );`
checks for the overflow of balance of the recipient. And there are no other instances in the entire smart contract where the user is
allowed to enter values to any state variable, hence avoiding the integer overflow and underflow.

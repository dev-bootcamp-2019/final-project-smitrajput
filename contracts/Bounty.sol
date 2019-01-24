pragma solidity ^0.5.0;

import 'openzeppelin-solidity/contracts/payment/PullPayment.sol';

contract BountyCreator is PullPayment {
    
    address public creator;
    uint public numberOfBounties;
    uint public totalFunding;
    mapping (uint => Bounty) bounties;
    uint public currentTime = now;

    
    //modifiers
    modifier onlyCreator() {
        require(msg.sender == creator);
        _;
    }

    modifier validBounty(uint bountyID) {
        require(bountyID >=0 && bountyID < numberOfBounties);
        _;
    }

    modifier validSubmission(uint bountyID, uint subID) {
        require(bountyID >=0 && bountyID < numberOfBounties && 
                subID >=0 && subID < bounties[bountyID].numberOfSubmissions);
        _;
    }
    
    modifier isActive(uint bountyID) {
        require(now < bounties[bountyID].startTime + bounties[bountyID].expiryTime * 1 days);
        _;
    }

    
    //events
    event BountyCreated(uint bountyID);
    event SubCreated(uint bountyID, uint subID);
    
    enum BountyState {
        Active,
        Inactive
    }
    
    enum SubStatus {
        Accepted,
        Pending,
        Rejected
    }
    
    struct Bounty {
        string task;
        uint reward;
        uint numberOfSubmissions;
        BountyState state;
        uint startTime;
        uint expiryTime;
        mapping(uint => Submission) submissions;
    }
    
    struct Submission {
        address payable author;
        string solution;
        SubStatus status;
    }
    
    constructor() public {
        creator = msg.sender;
    }
    
    function createBounty(string memory _task, uint _expiryTime) 
        public
        onlyCreator  
        payable
        returns (uint bountyID) 
    {
        bountyID = numberOfBounties++;
        bounties[bountyID] = Bounty(_task, msg.value, 0, BountyState.Active, now, _expiryTime);
        totalFunding += msg.value;
        emit BountyCreated(bountyID);
    }
    
    function changeReward(uint bountyID, uint newReward) 
        private
        onlyCreator 
        validBounty(bountyID) 
        isActive(bountyID)
    {
        bounties[bountyID].reward = newReward;
    }
    
    function getBountyDetails(uint bountyID) 
        public 
        view 
        validBounty(bountyID)
        returns(uint, uint, BountyState, uint, uint)
    {
        return (
            bounties[bountyID].reward,
            bounties[bountyID].numberOfSubmissions,
            bounties[bountyID].state,
            bounties[bountyID].startTime,
            bounties[bountyID].expiryTime
        );
    }
    
    function createSub(uint bountyID, string memory _solution) 
        public 
        isActive(bountyID)
        returns(uint subID)
    {
        subID = bounties[bountyID].numberOfSubmissions++;
        bounties[bountyID].submissions[subID] = Submission(msg.sender, _solution, SubStatus.Pending);
        emit SubCreated(bountyID, subID);
    }
    
    function getSubDetails(uint bountyID, uint subID) 
        public 
        view 
        validBounty(bountyID)
        validSubmission(bountyID, subID)
        returns(address, SubStatus)
    {
        return (
            bounties[bountyID].submissions[subID].author,
            bounties[bountyID].submissions[subID].status
        );
    }
    
    function acceptSubmission(uint bountyID, uint subID) 
        private 
        onlyCreator 
        validBounty(bountyID)
        validSubmission(bountyID, subID)
    {
        Bounty storage theBounty = bounties[bountyID];
        uint theReward = theBounty.reward;
        theBounty.reward = 0;
        _asyncTransfer(theBounty.submissions[subID].author, theReward);
        theBounty.state = BountyState.Inactive;
    }
}


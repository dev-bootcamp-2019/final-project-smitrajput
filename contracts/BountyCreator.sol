pragma solidity ^0.5.0;

import './Secure.sol';

contract BountyCreator is Secure {
    
    address public creatorAddress;
    string public creatorName;
    uint public numberOfBounties;
    uint public totalFunding;
    mapping (uint => Bounty) bounties;
    uint public currentTime = now;
    
    
    event BountyCreated(uint bountyID);
    event RewardChanged(uint bountyID, uint newReward);
    event SubCreated(uint bountyID, uint subID);
    event SubAccepted(address indexed author, uint reward);
    
    
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

    
    modifier onlyCreator() {
        require(msg.sender == creatorAddress);
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

    
    constructor(string memory name, address _creatorAddress) public {
        creatorAddress = _creatorAddress;
        creatorName = name;
    }
    
    function kill() public onlyOwner {
        selfdestruct(owner);
    }
    
    function createBounty(string memory _task, uint _expiryTime) 
        public
        onlyCreator 
        noEmergency
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
        emit RewardChanged(bountyID, newReward);
    }
    
    function getBountyDetails(uint bountyID) 
        public 
        view 
        validBounty(bountyID)
        returns(string memory, uint, uint, BountyState, uint, uint)
    {
        return (
            bounties[bountyID].task,
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
        noEmergency
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
        returns(string memory, address, SubStatus)
    {
        return (
            bounties[bountyID].submissions[subID].solution,
            bounties[bountyID].submissions[subID].author,
            bounties[bountyID].submissions[subID].status
        );
    }
    
    function acceptSubmission(uint bountyID, uint subID) 
        public 
        onlyCreator 
        validBounty(bountyID)
        validSubmission(bountyID, subID)
        noEmergency
    {
        Bounty storage theBounty = bounties[bountyID];
        uint theReward = theBounty.reward;
        require(
            theBounty.reward > 0 &&
            theBounty.state == BountyState.Active &&
            theBounty.submissions[subID].author.balance + theReward
            >= theBounty.submissions[subID].author.balance
        );
        theBounty.reward = 0;
        totalFunding -= theReward;
        theBounty.state = BountyState.Inactive;
        theBounty.submissions[subID].author.transfer(theReward);
        emit SubAccepted(theBounty.submissions[subID].author, theReward);
    }
}
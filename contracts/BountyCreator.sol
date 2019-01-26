pragma solidity ^0.5.0;

import './Secure.sol';

/** @title BountyCreator 
    @dev The contract representing a person who created a bounty on this dapp
    @author Smit Rajput
*/
contract BountyCreator is Secure {
    
    /** Storage */
    address public creatorAddress;
    string public creatorName;
    uint public numberOfBounties;
    uint public totalFunding;
    mapping (uint => Bounty) bounties;
    uint public currentTime = now;
    
    /** Events */
    event BountyCreated(uint bountyID);
    event RewardChanged(uint bountyID, uint newReward);
    event SubCreated(uint bountyID, uint subID);
    event SubAccepted(address indexed author, uint reward);
    
    /** Enums (custom constant data types) */
    enum BountyState {
        Active,
        Inactive
    }
    
    enum SubStatus {
        Accepted,
        Pending,
        Rejected
    }
    
    /** Structs (custom variable data types) */
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

    /** Modifiers */
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

    /** @dev The constructor to create this contract
        @param name Name of the bounty-creator
        @param _creatorAddress Address of the bounty-creator
     */
    constructor(string memory name, address _creatorAddress) public {
        creatorAddress = _creatorAddress;
        creatorName = name;
    }
    
    /** @dev To destroy this contract once the bounty-creator leaves the dapp permanently
        Only the dapp-owner can call this function
     */
    function kill() public onlyOwner {
        selfdestruct(owner);
    }
    
    /** @dev To create a bounty
        @param _task The bounty description
        @param _expiryTime Deadline to finish the bounty
        @return bountyID The ID of the new bounty
     */
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
    
    /** @dev To change the prize/reward of a bounty
        @param bountyID The ID of the bounty to change the reward of
        @param newReward The new reward to assign to the bounty
     */
    function changeReward(uint bountyID, uint newReward) 
        private
        onlyCreator 
        validBounty(bountyID) 
        isActive(bountyID)
    {
        bounties[bountyID].reward = newReward;
        emit RewardChanged(bountyID, newReward);
    }
    
    /** @dev To receive the complete details of a bounty
        @param bountyID The ID of the bounty to receive the details of
        @return All the details of the bounty, corresponding to bountyID
     */
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
    
    /** @dev To create a submission for a bounty
        @param bountyID The ID of the bounty to submit to
        @param _solution The solution to the bounty
        @return subID The ID of the new submission
     */
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
    
    /** @dev To receive the complete details of a submission to a bounty
        @param bountyID The ID of the bounty to which the submission belongs
        @param subID The ID of the submission to receive the details of
        @return All the details of the submission corresponding to the bountyID and subID
     */
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
    
    /** @dev To accept a particular submission to a bounty and pay him/her the reward
        @param bountyID The ID of the bounty to which the winning submission belongs
        @param subID The ID of the winning submission
        Only the bounty-creator can call this function, and that too in the state of no emergency
     */
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
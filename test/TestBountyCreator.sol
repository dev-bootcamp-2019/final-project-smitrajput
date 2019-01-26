pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/BountyCreator.sol";

/** @title TestBountyCreator 
    @dev The contract testing the functionalities of the BountyCreator contract
    @author Smit Rajput
*/
contract TestBountyCreator {

    /** Storage */
    BountyCreator creator;

    /** @dev The test hook to create a BountyCreator before every test
     */
    function beforeEach() public {
        creator = new BountyCreator("Bob", 0x76E1D4aB082Cc05F2439F8918937F5B26cc3AEb7);
    }

    /** @dev To test the creation of a valid bounty by checking on the total number of bounties 
    */
    function testCreatingBounty() public {
        creator.createBounty("some task", 5);

        Assert.equal(creator.numberOfBounties(), 1, "It should create a bounty");
    }

    /** @dev To check the creation of 2 valid submissions for a bounty by checking 
        on the incrementation in submission IDs 
        @notice subID = 0, after 1st submission
                subID = 1, after 2nd submission
    */
    function testCreatingSubmssions() public {
        uint subID;
        creator.createBounty("some task", 5);
        subID = creator.createSub(0, "first solution");
        subID = creator.createSub(0, "second solution");

        Assert.equal(subID, 1, "It should create 2 submissions");
    }

    /** @dev To check if the 1st 3 details of a bounty are properly retrievable  
    */
    function testSomeBountyDetails() public {
        uint bountyID = creator.createBounty("some task", 5);
        (string memory task, uint reward, uint numberOfSubmissions,,,) = creator.getBountyDetails(bountyID);

        Assert.equal(task, "some task", "It should return the bounty description");
        Assert.equal(reward, 0, "It should return the bounty reward");
        Assert.equal(numberOfSubmissions, 0, "It should return the number of submissions of a bounty");
    }

    /** @dev To check if the details of a submission are retrievable 
    */
    function testGettingSubmissionDetails() public {
        uint bountyID = creator.createBounty("some task", 5);
        uint subID = creator.createSub(0, "a solution");
        (string memory solution,,) = creator.getSubDetails(bountyID, subID);

        Assert.equal(solution, "a solution", "It should return all the submssion details");
    }

    /** @dev To check if the start and the expiry times of a bounty are retrievable and valid 
    */
    function testNewBountyExpiryTime() public {
        uint bountyID = creator.createBounty("some task", 5);
        (,,,,uint startTime, uint expiryTime) = creator.getBountyDetails(bountyID);

        Assert.isAbove(expiryTime-startTime, 0, "It should return a strictly positive bounty expiry time");
    }
}
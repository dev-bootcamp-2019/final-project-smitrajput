# Design Patterns used in the Smart Contract

### 1. Basic Smart Contract structure: Factory Style

![sc_design](https://user-images.githubusercontent.com/22425782/51806386-66b82780-229f-11e9-81e1-e43942103248.jpeg)

CreatorFactory.sol works like a factory and is responsible for deploying multiple instances of the BountyCreator contracts.

### 2. Fail early fail loud

Extensive use of modifiers has been made especially in the 'BountyCreator.sol' contract, so as to revert the transactions in case
of any mishap, instead of letting the mistakes take place silenty.

### 3. Mortal

A 'kill( )' method has been used in the 'BountyCreator.sol' contract to destroy the contracts of the bounty-creators who have left
the platform.

### 4. Circuit-breaker / Emergency-stop Pattern

'Secure.sol' has been purposefully created to implement this pattern and is hence inherited by all the contracts. It allows the 
dapp-owner to toggle the 'emergency state' of the dapp, so as to allow and disallow the functioning of different methods in all 
the contracts.

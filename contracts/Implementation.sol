//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Implementation is Ownable {
    string private greeting;

	 constructor () {
	 	 greeting = "Deployed!";
	 }

	 // Everyone can call this function
    function greet() public view returns (string memory) {
        return greeting;
    }

	 // Only owner can call this function
    function setGreeting(string memory _greeting) public onlyOwner {
        greeting = _greeting;
    }
}

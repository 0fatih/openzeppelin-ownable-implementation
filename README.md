# OpenZeppelin's Ownable

Hi, I will try to explain what OpenZeppelin's Ownable contract is and how can
we use it. Let's start!

## What is Ownable

Ownable is an access control contract. What does it mean? It means you can
manage function access in your contract with Ownable.

## Inspect

You can look at the Ownable contract from [here](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.3.0/contracts/access/Ownable.sol) by yourself.

First of all, we have a private address variable named `_owner`. That variable keeps the contract owner.
```solidity
address private _owner;
```

We have an event for owner transfership.
```solidity
event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
```

Here is our contract. It calls a function with the `_msgSender()` parameter. `_msgSender` is a function from [context](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.3.0/contracts/utils/Context.sol) and it returns `msg.sender`.
```solidity
constructor() {
    _setOwner(_msgSender());
}
```

A function for getting the owner.
```solidity
function owner() public view virtual returns (address) {
    return _owner;
}
```

The modifier is the thing we will use for our contracts. If a function implements this modifier, then only owner can call that function.
```solidity
modifier onlyOwner() {
    require(owner() == _msgSender(), "Ownable: caller is not the owner");
    _;
}
```

A function for renouncing ownership. When the contract owner calls it, there is no way to take the ownership the contract. So, it means no one can call those functions anymore except the one who implements `onlyOwner` modifier.
```solidity
function renounceOwnership() public virtual onlyOwner {
    _setOwner(address(0));
}
```

With this function, you can transfer the ownership of the contract. When you transfer the ownership to another account, you can't take it back if he doesn't want to give back to you.
```solidity
function transferOwnership(address newOwner) public virtual onlyOwner {
    require(newOwner != address(0), "Ownable: new owner is the zero address");
    _setOwner(newOwner);
}
```

These functions run only once, it is, when the constructor function is run.
```solidity
function _setOwner(address newOwner) private {
    address oldOwner = _owner;
    _owner = newOwner;
    emit OwnershipTransferred(oldOwner, newOwner);
}
```

## Implementation

Here is an example usage of `Ownable` in `contracts/Implementation.sol`.

```solidity
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
```

When you inherit a contract from Ownable, its constructor will run automatically. And the `msg.sender` (deployer) will be the owner of that contract.

If you want to interact or something else with this contract, you can look at usage of [hardhat](https://hardhat.org/getting-started/).
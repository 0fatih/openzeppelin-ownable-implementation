# OpenZeppelin's Ownable

Hi, I will try to explain what is OpenZeppelin's Ownable contract and how can we
use it. Let's start!

## What is Ownable

Ownable is an access control contract. What does it mean? It means you can
manage function access in your contract with Ownable.

## Inspect 

You can look at the Ownable contract from [here](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.3.0/contracts/access/Ownable.sol) by yourself.

First of all, we have a private address variable named _owner. That variable keeps the contract owner. 
```
address private _owner;
```

We have an event for owner transfership.
```
event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
```

Here is our contract. It is calls a function with the _msgSender() parameter. _msgSender is a function from [context](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.3.0/contracts/utils/Context.sol) and it is returns `msg.sender`.
```
constructor() {
    _setOwner(_msgSender());
}
```

A function for getting the owner.
```
function owner() public view virtual returns (address) {
    return _owner;
}
```

The modifier is we will use for our contracts. If a function implements this modifier, then only owner can call that function.
```
modifier onlyOwner() {
    require(owner() == _msgSender(), "Ownable: caller is not the owner");
    _;
}
```

A function for renouncing ownership. When the contract owner calls it, there is no way to take the contract's ownership. So it means: No one can call those functions who implements `onlyOwner` modifier anymore.
```
function renounceOwnership() public virtual onlyOwner {
    _setOwner(address(0));
}
```

With this function you can transfer the contract's ownership. When you transferred ownership to another account, you can't take it back if he doesn't wants to give it you back.
```
function transferOwnership(address newOwner) public virtual onlyOwner {
    require(newOwner != address(0), "Ownable: new owner is the zero address");
    _setOwner(newOwner);
}
```

This functions runs just one times, at the constructor.
```
function _setOwner(address newOwner) private {
    address oldOwner = _owner;
    _owner = newOwner;
    emit OwnershipTransferred(oldOwner, newOwner);
}
```

## Implementation

Here is an example of `Ownable` in `contracts/Implementation.sol`.

```
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

When you inherit a contract from Ownable, it's constructor will run automatically. And the msg.sender (deployer) will the owner of that contract. 

If you want to use, you can look usage of [hardhat](https://hardhat.org/getting-started/).
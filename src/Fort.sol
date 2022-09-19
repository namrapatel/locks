// SPDX-License-Identifier: MIT License
pragma solidity ^0.8.13;

contract Fort {
    
    address contractOwner;

    uint256 public health;
    string public name;
    address public heldBy;

    constructor(uint256 _health, string memory _name) {
        health = _health;
        name = _name;
        contractOwner = msg.sender;
        heldBy = address(0);
    }

    function takeDamage(uint256 damageToTake) external returns (uint256) {
        return health = health - damageToTake;
    }
    
    function setHeldBy(address player) external {
        heldBy = player;
    }
}
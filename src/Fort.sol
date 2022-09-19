// SPDX-License-Identifier: MIT License
pragma solidity ^0.8.13;

contract Fort {
    
    uint256 health;
    string name;
    address owner;

    constructor(uint256 _health, string memory _name) {
        health = _health;
        name = _name;
        owner = msg.sender;
    }

    function getHealth() public view returns (uint256) {
        return health;
    }
}
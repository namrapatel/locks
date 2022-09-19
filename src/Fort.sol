// SPDX-License-Identifier: MIT License
pragma solidity ^0.8.13;

contract Fort {
    
    uint256 public health;
    string public name;
    address owner;

    constructor(uint256 _health, string memory _name) {
        health = _health;
        name = _name;
        owner = msg.sender;
    }
}
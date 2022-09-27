// SPDX-License-Identifier: MIT License
pragma solidity ^0.8.13;

contract Market {

    address internal owner;

    uint256 internal weapon1Available = 12;
    uint256 internal weapon2Available = 8;
    uint256 internal weapon3Available = 4;
    uint256 internal constant weapon1Cost = 40;
    uint256 internal constant weapon2Cost = 80;
    uint256 internal constant weapon3Cost = 120;
    uint256 public constant weapon1 = 3;
    uint256 public constant weapon2 = 6;
    uint256 public constant weapon3 = 9;

    constructor() {
        owner = msg.sender;
    }

    // TODO: Change functions to internal instead?
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function.");
        _;
    }

    function buyWeapon1() public payable onlyOwner {
        require(weapon1Available > 0, "No weapon1 available.");
        require(msg.value >= weapon1Cost, "Not enough ether sent");
        weapon1Available--;
    }

    function buyWeapon2() public payable onlyOwner {
        require(weapon2Available > 0, "No weapon2 available.");
        require(msg.value >= weapon2Cost, "Not enough ether sent");
        weapon2Available--;
    }

    function buyWeapon3() public payable onlyOwner {
        require(weapon3Available > 0, "No weapon3 available.");
        require(msg.value >= weapon3Cost, "Not enough ether sent");
        weapon3Available--;
    }
}
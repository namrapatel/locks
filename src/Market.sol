// SPDX-License-Identifier: MIT License
pragma solidity ^0.8.13;

contract Market {

    uint256 power1Available = 12;
    uint256 power2Available = 8;
    uint256 power3Available = 4;
    uint256 power1Cost = 40;
    uint256 power2Cost = 80;
    uint256 power3Cost = 120;

    constructor() {
    }

    function buyPower1() public payable {
        require(msg.value >= power1Cost, "Not enough ether sent");
        power1Available--;
    }

    function buyPower2() public payable {
        require(msg.value >= power2Cost, "Not enough ether sent");
        power2Available--;
    }

    function buyPower3() public payable {
        require(msg.value >= power3Cost, "Not enough ether sent");
        power3Available--;
    }
}
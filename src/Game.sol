// SPDX-License-Identifier: MIT License
pragma solidity ^0.8.13;

import "./Fort.sol";

contract Game {
    
    mapping(uint256 => Fort) public forts;
    uint256 fortCount;

    constructor() {
        fortCount = 0;
        createFort(100, "Sardon's");
        createFort(150, "Swamptown");
        createFort(100, "Snow");
        createFort(150, "Castle");
        createFort(200, "MoD");
    }

    function createFort(uint256 _health, string memory _name) public {
        Fort fort = new Fort(_health, _name);
        forts[fortCount] = fort;
        fortCount++;
    }
    
}
// SPDX-License-Identifier: MIT License
pragma solidity ^0.8.13;

import "./Fort.sol";
import "./Market.sol";
import "./players/Player.sol";

contract Game {
    
    mapping(uint256 => Fort) public forts;
    uint256 fortCount;

    Market market;

    struct PlayerData {
        uint256 power;
        uint256 health;
        uint256 timeHeld;
        Player player;
    }

    Player[] public players;

    mapping(Player => PlayerData) public getPlayerData;

    constructor() {
        fortCount = 0;
        createFort(100, "Sardon's");
        createFort(150, "Swamptown");
        createFort(100, "Snow");
        createFort(150, "Castle");
        createFort(200, "MoD");

        market = new Market();
    }
    
    function createFort(uint256 _health, string memory _name) public {
        Fort fort = new Fort(_health, _name);
        forts[fortCount] = fort;
        fortCount++;
    }
}
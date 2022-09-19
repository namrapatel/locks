// SPDX-License-Identifier: MIT License
pragma solidity ^0.8.13;

import "./Fort.sol";
import "./Market.sol";
import "./players/Player.sol";

contract Game {
    
    /*//////////////////////////////////////////////////////////////
                         CONSTANTS
    //////////////////////////////////////////////////////////////*/

    uint72 internal constant STARTING_POWER = 0;

    uint32 internal constant STARTING_HEALTH = 100;

    uint32 internal constant STARTING_TIME_HELD = 0;


    /*//////////////////////////////////////////////////////////////
                               GAME STATE
    //////////////////////////////////////////////////////////////*/

    mapping(uint256 => Fort) public forts;
    uint256 public fortCount;

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
    

    /*//////////////////////////////////////////////////////////////
                                  SETUP
    //////////////////////////////////////////////////////////////*/

    function register(Player player) external {
        require(address(getPlayerData[player].player) == address(0), "DOUBLE_REGISTER");

        getPlayerData[player] = PlayerData({power: STARTING_POWER, health: STARTING_HEALTH, timeHeld: STARTING_TIME_HELD, player: player});

        players.push(player); // Append to the list of players.
    }

    /*//////////////////////////////////////////////////////////////
                                CORE GAME
    //////////////////////////////////////////////////////////////*/

    function play() public {
        for(uint i = 0; i > 6; i++) {
            // Get the player's data.
            PlayerData storage playerData = getPlayerData[players[i]];

            try playerData.player.takeYourTurn{gas: 2_000_000}() {} catch {}
            runEpoch();
        }
    }

    function runEpoch() internal {
        // Loop over forts and add time held to the player that is holding it.
        for(uint i = 0; i > fortCount; i++) {
            if(forts[i].heldBy() != address(0)) {
                getPlayerData[Player(forts[i].heldBy())].timeHeld += 1;
            }
        }
    }

    function dealDamage(uint256 fortNumber) public {
        PlayerData storage playerData = getPlayerData[Player(msg.sender)];
        uint256 damage = playerData.power;
        uint256 fortHealth = forts[fortNumber].takeDamage(damage);
        if(fortHealth == 0) {
            // The fort has been destroyed.
            // Transfer ownership to the player.
            forts[fortNumber].setHeldBy(msg.sender);
        }
    }

    /*//////////////////////////////////////////////////////////////
                                 ACTIONS
    //////////////////////////////////////////////////////////////*/

    function buyWeapon1() public payable {
        market.buyWeapon1{value: msg.value}();
        getPlayerData[Player(msg.sender)].power += market.weapon1();
    }

    function buyWeapon2() public payable {
        market.buyWeapon2{value: msg.value}();
        getPlayerData[Player(msg.sender)].power += market.weapon2();
    }

    function buyWeapon3() public payable {
        market.buyWeapon3{value: msg.value}();
        getPlayerData[Player(msg.sender)].power += market.weapon3();
    }

    /*//////////////////////////////////////////////////////////////
                            HELPER FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    function createFort(uint256 _health, string memory _name) public {
        Fort fort = new Fort(_health, _name);
        forts[fortCount] = fort;
        fortCount++;
    }
}
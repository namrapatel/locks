// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import "../Game.sol";

abstract contract Player {
    Game internal immutable game;

    constructor(Game _game) {
        game = _game;
    }

    function takeYourTurn() external virtual; // TODO: add parameters
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Seed.sol";

contract SeedTest is Test {

    Seed seed;

    function setup() public {
        seed = new Seed();
    }
}

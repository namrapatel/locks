// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Seed.sol";
import "../src/DummyContract.sol";

contract SeedTest is Test {

    Seed seed;
    DummyContract dummyContract;

    function setup() public {
        seed = new Seed();
        dummyContract = new DummyContract();
    }
}

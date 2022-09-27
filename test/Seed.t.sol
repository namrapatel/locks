// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// Foundry
import {DSTestPlus} from "solmate/test/utils/DSTestPlus.sol";
import {Utilities} from "./utils/Utilities.sol";
import {console} from "./utils/Console.sol";
import {Vm} from "forge-std/Vm.sol";

// Contracts
import "../src/Seed.sol";
import "../src/DummyContract.sol";

contract SeedTest is DSTestPlus {

    Vm internal immutable vm = Vm(HEVM_ADDRESS);
    Utilities internal utils;

    Seed seed;
    DummyContract dummyContract;

    function setup() public {
        utils = new Utilities();

        seed = new Seed();
        dummyContract = new DummyContract();
    }

    function testOpcodeExists() public {
        bool opcodeExists = seed.checkOpcodeExists(address(dummyContract));
        assertBoolEq(opcodeExists, true);
    }   
}

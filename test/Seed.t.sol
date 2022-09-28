// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// Foundry
import {DSTestPlus} from "solmate/test/utils/DSTestPlus.sol";
import {Utilities} from "./utils/Utilities.sol";
import {console} from "./utils/Console.sol";
import {Vm} from "forge-std/Vm.sol";

// Contracts
import "./mocks/Seed.sol";
import "./mocks/MockSSTORE.sol";
import "./mocks/MockSLOAD.sol";
import "../src/libraries/LibSearch.sol";

contract SeedTest is DSTestPlus {

    Vm internal immutable vm = Vm(HEVM_ADDRESS);
    Utilities internal utils;

    Seed seed;
    MockSSTORE mockSSTORE;
    MockSLOAD mockSLOAD;

    function setUp() public {
        utils = new Utilities();

        seed = new Seed();
        mockSSTORE = new MockSSTORE();
        mockSLOAD = new MockSLOAD();
    }

    function testOpcodeExists() public {
        bool opcodeExists = LibSearch.checkOpcodeExists(address(mockSSTORE));
        assertTrue(opcodeExists);
    } 

    function testFailOpcodeDoesNotExist() public {
        bool opcodeExists = LibSearch.checkOpcodeExists(address(mockSLOAD));
        assertTrue(opcodeExists);
    }
}

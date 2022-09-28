// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// Foundry
import {DSTestPlus} from "solmate/test/utils/DSTestPlus.sol";
import {Utilities} from "./utils/Utilities.sol";
import {console} from "./utils/Console.sol";
import {Vm} from "forge-std/Vm.sol";

// Contracts
import "./mocks/MockDefault.sol";
import "./mocks/MockSSTORE.sol";
import "./mocks/MockSLOAD.sol";
import "../src/libraries/LibSearch.sol";

contract LibSearchTest is DSTestPlus {

    Vm internal immutable vm = Vm(HEVM_ADDRESS);
    Utilities internal utils;

    MockDefault mockDefault;
    MockSSTORE mockSSTORE;
    MockSLOAD mockSLOAD;

    function setUp() public {
        utils = new Utilities();

        mockDefault = new MockDefault();
        mockSSTORE = new MockSSTORE();
        mockSLOAD = new MockSLOAD();
    }

    // Test if a specific opcode exists in a contract (SSTORE/0x55) in this case
    function testOpcodeExists() public {
        bytes32 opcode = bytes32(uint256(0x55));
        bool opcodeExists = LibSearch.checkOpcodeExists(address(mockSSTORE), opcode);
        assertTrue(opcodeExists);
    } 

    // Test that checkOpcodeExists correctly returns false if the opcode does not exist
    function testFailOpcodeDoesNotExist() public {
        bytes32 opcode = bytes32(uint256(0x55));
        bool opcodeExists = LibSearch.checkOpcodeExists(address(mockSLOAD), opcode);
        assertTrue(opcodeExists);
    }

    // Test if a list of opcodes exists in a contract (SLOAD/0x54 and SSTORE/0x55) in this case
    function testOneOfTheOpcodesExists() public {
        bytes32[] memory opcodes = new bytes32[](2);
        opcodes[0] = bytes32(uint256(0x55));
        opcodes[1] = bytes32(uint256(0x56));
        bool opcodeExists = LibSearch.checkOpcodeExists(address(mockSSTORE), opcodes);
        assertTrue(opcodeExists);
    }

    // Test that checkOpcodeExists correctly returns false if none of the opcodes exist
    function testFailNoneOfTheOpcodesExist() public {
        bytes32[] memory opcodes = new bytes32[](2);
        opcodes[0] = bytes32(uint256(0x54));
        opcodes[1] = bytes32(uint256(0x55));
        bool opcodeExists = LibSearch.checkOpcodeExists(address(mockDefault), opcodes);
        assertTrue(opcodeExists);
    }
}

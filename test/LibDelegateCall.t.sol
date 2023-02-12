// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// Foundry
import {DSTestPlus} from "solmate/test/utils/DSTestPlus.sol";
import {Utilities} from "./utils/Utilities.sol";
import {console} from "./utils/Console.sol";
import {Vm} from "forge-std/Vm.sol";

// Contracts
import "./mocks/MockDefault.sol";
import "./mocks/delegatecall/MockDelegateCall.sol";
import "../src/libraries/LibDelegateCall.sol";

contract LibDelegateCallTest is DSTestPlus {

    Vm internal immutable vm = Vm(HEVM_ADDRESS);
    Utilities internal utils;

    MockDefault mockDefault;
    MockDelegateCall mockDelegateCall;

    function setUp() public {
        utils = new Utilities();

        mockDefault = new MockDefault();
        mockDelegateCall = new MockDelegateCall();
    }

    function testCheckDelegateCall() public {
        address[] memory blacklist = new address[](4);
        blacklist[0] = address(0x0);
        blacklist[1] = address(0x1);
        blacklist[2] = mockDelegateCall.CALLER();
        blacklist[3] = mockDelegateCall.CALLEE();
        assertTrue(LibDelegateCall.checkCall(address(mockDelegateCall), blacklist));
    }

      function testCheckDelegateCallAndFunction() public {
        // Check that checkCallAndFunction returns true when submitted contract uses CALL opcode and calls an address in the blacklist
        address[] memory blacklist = new address[](4);
        blacklist[0] = address(0x0);
        blacklist[1] = address(0x1);
        blacklist[2] = mockDelegateCall.CALLER();
        blacklist[3] = address(0xb0EdA4f836aF0F8Ca667700c42fcEFA0742ae2B5);
        uint8[] memory functionsPerAddr = new uint8[](4);
        functionsPerAddr[0] = 0;
        functionsPerAddr[1] = 0;
        functionsPerAddr[2] = 0;
        functionsPerAddr[3] = 2;

        bytes4[] memory functionSelectors = new bytes4[](1);
        functionSelectors[0] = bytes4(keccak256("fakeFunc(uint256)"));

        assertTrue(LibDelegateCall.checkCallAndFunction(address(mockDelegateCall), blacklist, functionsPerAddr, functionSelectors));
    }
}
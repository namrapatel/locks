// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// Foundry
import {DSTestPlus} from "solmate/test/utils/DSTestPlus.sol";
import {Utilities} from "./utils/Utilities.sol";
import {console} from "./utils/Console.sol";
import {Vm} from "forge-std/Vm.sol";

// Contracts
import "./mocks/MockDefault.sol";
import "./mocks/call/MockCall.sol";
import "../src/libraries/LibCall.sol";

contract LibCallTest is DSTestPlus {

    Vm internal immutable vm = Vm(HEVM_ADDRESS);
    Utilities internal utils;

    MockDefault mockDefault;
    MockCall mockCall;

    function setUp() public {
        utils = new Utilities();

        mockDefault = new MockDefault();
        mockCall = new MockCall();
    }

    // function testCheckCallOpcodeSearchWorks() public {
    //     // Check that checkCall returns false when submitted contract does not use CALL opcode
    //     assertTrue(!LibCall.checkCall(address(mockDefault), new address[](0)));
    // }

    function testCheckCall() public {
        // Check that checkCall returns true when submitted contract uses CALL opcode and calls an address in the blacklist
        address[] memory blacklist = new address[](4);
        blacklist[0] = address(0x0);
        blacklist[1] = address(0x1);
        blacklist[2] = mockCall.CALLER();
        blacklist[3] = address(0xb0EdA4f836aF0F8Ca667700c42fcEFA0742ae2B5);
        assertTrue(LibCall.checkCall(address(mockCall), blacklist));
    }

    function testFailCheckCallThatShouldFail() public {
        // Check that checkCall reverts when submitted contract uses CALL opcode and calls an address not in the blacklist
        address[] memory blacklist = new address[](5);
        blacklist[0] = address(0x0);
        blacklist[1] = address(0x1);
        blacklist[2] = address(0x2);
        blacklist[3] = address(0x3);
        blacklist[4] = address(0x4);
        assertTrue(LibCall.checkCall(address(mockCall), blacklist));
    }

    function testCheckCallAndFunction() public {
        // Check that checkCallAndFunction returns true when submitted contract uses CALL opcode and calls an address in the blacklist
        address[] memory blacklist = new address[](4);
        blacklist[0] = address(0x0);
        blacklist[1] = address(0x1);
        blacklist[2] = mockCall.CALLER();
        blacklist[3] = address(0xb0EdA4f836aF0F8Ca667700c42fcEFA0742ae2B5);
        assertTrue(LibCall.checkCallAndFunction(address(mockCall), blacklist, "coolFunc()"));
    }

}

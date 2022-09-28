// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// Foundry
import {DSTestPlus} from "solmate/test/utils/DSTestPlus.sol";
import {Utilities} from "./utils/Utilities.sol";
import {console} from "./utils/Console.sol";
import {Vm} from "forge-std/Vm.sol";

// Contracts
import "./mocks/MockDefault.sol";
import "./mocks/MockCall.sol";
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

    function test_checkCall() public {
        // Check that checkCall returns false when submitted contract does not use CALL opcode
        // assertTrue(!LibCall.checkCall(address(mockDefault), new address[](0)));

        // Check that checkCall returns true when submitted contract uses CALL opcode and calls an address in the blacklist
        address[] memory blacklist = new address[](1);
        blacklist[0] = mockCall.CALLER();
        assertTrue(LibCall.checkCall(address(mockCall), blacklist));
    }

}

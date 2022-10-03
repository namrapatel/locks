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
}
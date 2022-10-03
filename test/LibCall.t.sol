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
import "./mocks/call/MockCall1.sol";
import "./mocks/call/MockCall2.sol";
import "./mocks/call/MockCall3.sol";
import "./mocks/call/MockCall4.sol";
import "./mocks/call/MockCall5.sol";
import "./mocks/call/MockCall6.sol";
import "./mocks/call/MockCall7.sol";
import "./mocks/call/MockCall8.sol";
import "../src/libraries/LibCall.sol";

contract LibCallTest is DSTestPlus {

    Vm internal immutable vm = Vm(HEVM_ADDRESS);
    Utilities internal utils;

    MockDefault mockDefault;
    MockCall mockCall;
    MockCall1 mockCall1;
    MockCall2 mockCall2;
    MockCall3 mockCall3;
    MockCall4 mockCall4;
    MockCall5 mockCall5;
    MockCall6 mockCall6;
    MockCall7 mockCall7;
    MockCall8 mockCall8;

    function setUp() public {
        utils = new Utilities();

        mockDefault = new MockDefault();
        mockCall = new MockCall();
        mockCall1 = new MockCall1();
        mockCall2 = new MockCall2();
        mockCall3 = new MockCall3();
        mockCall4 = new MockCall4();
        mockCall5 = new MockCall5();
        mockCall6 = new MockCall6();
        mockCall7 = new MockCall7();
        mockCall8 = new MockCall8();
    }

    function testCheckCallOpcodeSearchWorks() public {
        // Check that checkCall returns false when submitted contract does not use CALL opcode
        assertTrue(!LibCall.checkCall(address(mockDefault), new address[](0)));
    }

    function testCheckCall() public {
        // Check that checkCall returns true when submitted contract uses CALL opcode and calls an address in the blacklist
        address[] memory blacklist = new address[](4);
        blacklist[0] = address(0x0);
        blacklist[1] = address(0x1);
        blacklist[2] = mockCall.CALLER();
        blacklist[3] = mockCall.CALLEE();
        assertTrue(LibCall.checkCall(address(mockCall), blacklist));
    }

    function testCheckCall1() public {
        // Check that checkCall returns true when submitted contract uses CALL opcode and calls an address in the blacklist
        address[] memory blacklist = new address[](4);
        blacklist[0] = address(0x0);
        blacklist[1] = address(0x1);
        blacklist[2] = mockCall1.CALLER();
        blacklist[3] = mockCall1.CALLEE();
        assertTrue(LibCall.checkCall(address(mockCall1), blacklist));
    }

    function testCheckCall2() public {
        // Check that checkCall returns true when submitted contract uses CALL opcode and calls an address in the blacklist
        address[] memory blacklist = new address[](4);
        blacklist[0] = address(0x0);
        blacklist[1] = address(0x1);
        blacklist[2] = mockCall2.CALLER();
        blacklist[3] = mockCall2.CALLEE();
        assertTrue(LibCall.checkCall(address(mockCall2), blacklist));
    }

    function testCheckCall3() public {
        // Check that checkCall returns true when submitted contract uses CALL opcode and calls an address in the blacklist
        address[] memory blacklist = new address[](4);
        blacklist[0] = address(0x0);
        blacklist[1] = address(0x1);
        blacklist[2] = mockCall3.CALLER();
        blacklist[3] = mockCall3.CALLEE();
        assertTrue(LibCall.checkCall(address(mockCall3), blacklist));
    }

    function testCheckCall4() public {
        // Check that checkCall returns true when submitted contract uses CALL opcode and calls an address in the blacklist
        address[] memory blacklist = new address[](4);
        blacklist[0] = address(0x0);
        blacklist[1] = address(0x1);
        blacklist[2] = mockCall4.CALLER();
        blacklist[3] = mockCall4.CALLEE();
        assertTrue(LibCall.checkCall(address(mockCall4), blacklist));
    }

    function testCheckCall5() public {
        // Check that checkCall returns true when submitted contract uses CALL opcode and calls an address in the blacklist
        address[] memory blacklist = new address[](4);
        blacklist[0] = address(0x0);
        blacklist[1] = address(0x1);
        blacklist[2] = mockCall5.CALLER();
        blacklist[3] = mockCall5.CALLEE();
        assertTrue(LibCall.checkCall(address(mockCall5), blacklist));
    }

    function testCheckCall6() public {
        // Check that checkCall returns true when submitted contract uses CALL opcode and calls an address in the blacklist
        address[] memory blacklist = new address[](4);
        blacklist[0] = address(0x0);
        blacklist[1] = address(0x1);
        blacklist[2] = mockCall6.CALLER();
        blacklist[3] = mockCall6.CALLEE();
        assertTrue(LibCall.checkCall(address(mockCall6), blacklist));
    }

    function testCheckCall7() public {
        // Check that checkCall returns true when submitted contract uses CALL opcode and calls an address in the blacklist
        address[] memory blacklist = new address[](4);
        blacklist[0] = address(0x0);
        blacklist[1] = address(0x1);
        blacklist[2] = mockCall7.CALLER();
        blacklist[3] = mockCall7.CALLEE();
        assertTrue(LibCall.checkCall(address(mockCall7), blacklist));
    }

    function testCheckCall8() public {
        // Check that checkCall returns true when submitted contract uses CALL opcode and calls an address in the blacklist
        address[] memory blacklist = new address[](4);
        blacklist[0] = address(0x0);
        blacklist[1] = address(0x1);
        blacklist[2] = mockCall8.CALLER();
        blacklist[3] = mockCall8.CALLEE();
        assertTrue(LibCall.checkCall(address(mockCall8), blacklist));
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
        uint8[] memory functionsPerAddr = new uint8[](4);
        functionsPerAddr[0] = 0;
        functionsPerAddr[1] = 0;
        functionsPerAddr[2] = 0;
        functionsPerAddr[3] = 2;

        bytes4[] memory functionSelectors = new bytes4[](1);
        functionSelectors[0] = bytes4(keccak256("coolFunc(uint256)"));

        assertTrue(LibCall.checkCallAndFunction(address(mockCall), blacklist, functionsPerAddr, functionSelectors));
    }

    function testCheckCallAndFunction1() public {
        // Check that checkCall returns true when submitted contract uses CALL opcode and calls an address in the blacklist
        address[] memory blacklist = new address[](4);
        blacklist[0] = address(0x0);
        blacklist[1] = mockCall1.FAKEADDR();
        blacklist[2] = mockCall1.CALLER();
        blacklist[3] = address(0xb0EdA4f836aF0F8Ca667700c42fcEFA0742ae2B5);
        
        uint8[] memory functionsPerAddr = new uint8[](4);
        functionsPerAddr[0] = 1;
        functionsPerAddr[1] = 2;
        functionsPerAddr[2] = 1;
        functionsPerAddr[3] = 2;

        bytes4[] memory functionSelectors = new bytes4[](6);
        // address(0x0)
        functionSelectors[0] = bytes4(keccak256("weirdFunc(uint256)"));
        // address(FAKEADDR)
        functionSelectors[1] = bytes4(keccak256("coolFunc(uint256)"));
        functionSelectors[2] = bytes4(keccak256("weirdFunc(uint256)"));
        // address(0x6dfc34609a05bC22319fA4Cce1d1E2929548c0D7)
        functionSelectors[3] = bytes4(keccak256("coolFunc(uint256)"));
        // address(0xb0EdA4f836aF0F8Ca667700c42fcEFA0742ae2B5)
        functionSelectors[4] = bytes4(keccak256("niceFunc(uint256)"));
        functionSelectors[5] = bytes4(keccak256("weirdFunc(uint256)"));
        
        assertTrue(LibCall.checkCallAndFunction(address(mockCall1), blacklist, functionsPerAddr, functionSelectors));
    }

    function testFailCheckCallAndFunction2() public {
        // Check that checkCall returns true when submitted contract uses CALL opcode and calls an address in the blacklist
        address[] memory blacklist = new address[](4);
        blacklist[0] = address(0x0);
        blacklist[1] = address(0x1);
        blacklist[2] = mockCall2.CALLER();
        blacklist[3] = address(0xb0EdA4f836aF0F8Ca667700c42fcEFA0742ae2B5);
        uint8[] memory functionsPerAddr = new uint8[](4);
        functionsPerAddr[0] = 0;
        functionsPerAddr[1] = 0;
        functionsPerAddr[2] = 0;
        functionsPerAddr[3] = 2;

        bytes4[] memory functionSelectors = new bytes4[](1);
        functionSelectors[0] = bytes4(keccak256("coolFunc(uint256)"));

        assertTrue(LibCall.checkCallAndFunction(address(mockCall2), blacklist, functionsPerAddr, functionSelectors));
    }

    function testCheckCallAndFunction3() public {
        // Check that checkCall returns true when submitted contract uses CALL opcode and calls an address in the blacklist
        address[] memory blacklist = new address[](4);
        blacklist[0] = address(0x0);
        blacklist[1] = address(0x1);
        blacklist[2] = mockCall3.CALLER();
        blacklist[3] = address(0xb0EdA4f836aF0F8Ca667700c42fcEFA0742ae2B5);
        uint8[] memory functionsPerAddr = new uint8[](4);
        functionsPerAddr[0] = 0;
        functionsPerAddr[1] = 0;
        functionsPerAddr[2] = 0;
        functionsPerAddr[3] = 2;

        bytes4[] memory functionSelectors = new bytes4[](1);
        functionSelectors[0] = bytes4(keccak256("fakeFunc(uint256)"));

        assertTrue(LibCall.checkCallAndFunction(address(mockCall3), blacklist, functionsPerAddr, functionSelectors));
    }

    function testCheckCallAndFunction4() public {
        // Check that checkCall returns true when submitted contract uses CALL opcode and calls an address in the blacklist
        address[] memory blacklist = new address[](4);
        blacklist[0] = address(0x0);
        blacklist[1] = address(0x1);
        blacklist[2] = mockCall4.CALLER();
        blacklist[3] = address(0xb0EdA4f836aF0F8Ca667700c42fcEFA0742ae2B5);
        uint8[] memory functionsPerAddr = new uint8[](4);
        functionsPerAddr[0] = 0;
        functionsPerAddr[1] = 0;
        functionsPerAddr[2] = 0;
        functionsPerAddr[3] = 2;

        bytes4[] memory functionSelectors = new bytes4[](1);
        functionSelectors[0] = bytes4(keccak256("niceFunc(uint256)"));

        assertTrue(LibCall.checkCallAndFunction(address(mockCall4), blacklist, functionsPerAddr, functionSelectors));
    }

    function testCheckCallAndFunction5() public {
        // Check that checkCall returns true when submitted contract uses CALL opcode and calls an address in the blacklist
        address[] memory blacklist = new address[](4);
        blacklist[0] = address(0x0);
        blacklist[1] = address(0x1);
        blacklist[2] = mockCall5.CALLER();
        blacklist[3] = address(0xb0EdA4f836aF0F8Ca667700c42fcEFA0742ae2B5);
        uint8[] memory functionsPerAddr = new uint8[](4);
        functionsPerAddr[0] = 0;
        functionsPerAddr[1] = 0;
        functionsPerAddr[2] = 0;
        functionsPerAddr[3] = 2;

        bytes4[] memory functionSelectors = new bytes4[](1);
        functionSelectors[0] = bytes4(keccak256("fakeFunc(uint256)"));

        assertTrue(LibCall.checkCallAndFunction(address(mockCall5), blacklist, functionsPerAddr, functionSelectors));
    }

    function testCheckCallAndFunction6() public {
        // Check that checkCall returns true when submitted contract uses CALL opcode and calls an address in the blacklist
        address[] memory blacklist = new address[](4);
        blacklist[0] = address(0x0);
        blacklist[1] = address(0x1);
        blacklist[2] = mockCall6.CALLER();
        blacklist[3] = address(0xb0EdA4f836aF0F8Ca667700c42fcEFA0742ae2B5);
        uint8[] memory functionsPerAddr = new uint8[](4);
        functionsPerAddr[0] = 0;
        functionsPerAddr[1] = 0;
        functionsPerAddr[2] = 0;
        functionsPerAddr[3] = 2;

        bytes4[] memory functionSelectors = new bytes4[](1);
        functionSelectors[0] = bytes4(keccak256("niceFunc(uint256)"));

        assertTrue(LibCall.checkCallAndFunction(address(mockCall6), blacklist, functionsPerAddr, functionSelectors));
    }

    function testCheckCallAndFunction7() public {
        // Check that checkCall returns true when submitted contract uses CALL opcode and calls an address in the blacklist
        address[] memory blacklist = new address[](4);
        blacklist[0] = address(0x0);
        blacklist[1] = address(0x1);
        blacklist[2] = mockCall7.CALLER();
        blacklist[3] = address(0xb0EdA4f836aF0F8Ca667700c42fcEFA0742ae2B5);
        uint8[] memory functionsPerAddr = new uint8[](4);
        functionsPerAddr[0] = 0;
        functionsPerAddr[1] = 0;
        functionsPerAddr[2] = 0;
        functionsPerAddr[3] = 2;

        bytes4[] memory functionSelectors = new bytes4[](1);
        functionSelectors[0] = bytes4(keccak256("register(string)"));

        assertTrue(LibCall.checkCallAndFunction(address(mockCall7), blacklist, functionsPerAddr, functionSelectors));
    }

    function testCheckCallAndFunction8() public {
        // Check that checkCall returns true when submitted contract uses CALL opcode and calls an address in the blacklist
        address[] memory blacklist = new address[](4);
        blacklist[0] = address(0x0);
        blacklist[1] = address(0x1);
        blacklist[2] = mockCall8.CALLER();
        blacklist[3] = address(0xb0EdA4f836aF0F8Ca667700c42fcEFA0742ae2B5);
        uint8[] memory functionsPerAddr = new uint8[](4);
        functionsPerAddr[0] = 0;
        functionsPerAddr[1] = 0;
        functionsPerAddr[2] = 0;
        functionsPerAddr[3] = 2;

        bytes4[] memory functionSelectors = new bytes4[](4);
        functionSelectors[0] = bytes4(keccak256("register(string)"));

        assertTrue(LibCall.checkCallAndFunction(address(mockCall8), blacklist, functionsPerAddr, functionSelectors));
    }    
}

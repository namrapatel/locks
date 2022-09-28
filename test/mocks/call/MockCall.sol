// SPDX-License-Identifier: MIT License
pragma solidity ^0.8.13;

contract MockCallee {

    function testFunc() public pure returns (uint) {
        return 1;
    }

    function testFunc1(uint num) public pure returns (uint) {
        return 2;
    }
}

contract MockCall {

    address public constant CALLER = 0x6dfc34609a05bC22319fA4Cce1d1E2929548c0D7;
    address public constant CALLER2 = 0xc0E53C70dD53b5e1A8275Aa65ec07F20038F8317;
    address public constant CALLEE = 0xb0EdA4f836aF0F8Ca667700c42fcEFA0742ae2B5;

    // contract.func() with no arguments
    function call0() public {
        MockCallee callee = MockCallee(CALLEE);
        callee.testFunc();
    }

    // contract.func(arg) with 1 argument
    function call1() public {
        MockCallee callee = MockCallee(CALLEE);
        callee.testFunc1(1);
    }

    // .call() with no 1 empty string argument
    function call2() public {
        CALLER.call("");
    }

    // .call() with abi.encodeWithSignature()
    function call3() public {
        (bool success, bytes memory data) = CALLER.call(abi.encodeWithSignature("testFunc()"));
    }

    // .call() with abi.encodeWithSelector()
    function call4() public {
        (bool success, bytes memory data) = CALLER.call(abi.encodeWithSelector(bytes4(keccak256("testFunc()"))));
    }

    // .call() with abi.encodeCall()
    function call5() public {
        (bool success, bytes memory data) = CALLER.call(abi.encodeCall(
            MockCallee.testFunc,
            ())
        );
    }

    // .call() with abi.encodeCall() with 1 argument
    function call6() public {
        (bool success, bytes memory data) = CALLER.call(abi.encodeCall(
            MockCallee.testFunc1,
            (1))
        );
    }

    // .call() on address from storage
    function call7() public {
        bytes memory payload = abi.encodeWithSignature("register(string)", "MyName");
        (bool success, bytes memory returnData) = CALLER.call(payload);
    }

    // .call() on address created in memory
    function call8() public {
        bytes memory payload = abi.encodeWithSignature("register(string)", "MyName");
        (bool success, bytes memory returnData) = address(0x6dfc34609a05bC22319fA4Cce1d1E2929548c0D7).call(payload);
    }
}
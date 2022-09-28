// SPDX-License-Identifier: MIT License
pragma solidity ^0.8.13;

contract MockCallee1 {

    uint coolNum = 0;

    function fakeFunc() public returns (uint) {
        coolNum++;
        return 1;
    }

    function fakeFunc1(uint num) public returns (uint) {
        coolNum += num;
        return 2;
    }
}

contract MockCall1 {

    address public constant CALLER = 0x6dfc34609a05bC22319fA4Cce1d1E2929548c0D7;
    address public constant CALLER2 = 0xc0E53C70dD53b5e1A8275Aa65ec07F20038F8317;
    address public constant CALLEE = 0xb0EdA4f836aF0F8Ca667700c42fcEFA0742ae2B5;

    // contract.func(arg) with 1 argument
    function call() public {
        MockCallee1 callee = MockCallee1(CALLEE);
        callee.fakeFunc1(1);
    }
}
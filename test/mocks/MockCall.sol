// SPDX-License-Identifier: MIT License
pragma solidity ^0.8.13;

contract MockCall {

    address public constant CALLER = 0x6dfc34609a05bC22319fA4Cce1d1E2929548c0D7;
    address public constant CALLER2 = 0xc0E53C70dD53b5e1A8275Aa65ec07F20038F8317;

    function callSpecificAddress() public {
        CALLER.call("");
    }

    function callAnotherSpecificAddress() public {
        CALLER2.call("");
    }
}
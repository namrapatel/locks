// SPDX-License-Identifier: MIT License
pragma solidity ^0.8.13;

contract MockCall {

    address public constant CALLER = 0x6dfc34609a05bC22319fA4Cce1d1E2929548c0D7;

    function callSpecificAddress() public {
        CALLER.call("");
    }
    
}
// SPDX-License-Identifier: MIT License
pragma solidity ^0.8.13;

contract MockCallee {

    uint coolNum = 0;

    function fakeFunc(uint256 num) public returns (uint) {
        coolNum = num;
        return 1;
    }

    function niceFunc(uint256 num) public returns (uint) {
        coolNum += num;
        return 2;
    }

    function coolFunc(uint256 num) public returns (uint) {
        coolNum += num;
        return 1;
    }

    function weirdFunc(uint256 num) public returns (uint) {
        coolNum += num;
        return 2;
    }
}
// SPDX-License-Identifier: MIT License
pragma solidity ^0.8.13;

contract MockCallee {

    uint coolNum = 0;

    function fakeFunc(uint num) public returns (uint) {
        coolNum = num;
        return 1;
    }

    function fakeFunc1(uint num) public returns (uint) {
        coolNum += num;
        return 2;
    }

    function coolFunc(uint num) public returns (uint) {
        coolNum += num;
        return 1;
    }

    function coolFunc1(uint num) public returns (uint) {
        coolNum += num;
        return 2;
    }
}
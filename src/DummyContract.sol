// SPDX-License-Identifier: MIT License
pragma solidity ^0.8.13;

contract DummyContract {

    string public dummyString = "Hello World";

    function dummyFunction() external pure returns (uint256) {
        return 42;
    }
}
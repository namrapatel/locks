// SPDX-License-Identifier: MIT License
pragma solidity ^0.8.13;

contract DummyContract {

    function dummyFunction() external returns (uint256) {
        assembly {
            sstore(25, 42)
        }
        return 42;
    }
}
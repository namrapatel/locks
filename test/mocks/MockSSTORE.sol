// SPDX-License-Identifier: MIT License
pragma solidity ^0.8.13;

contract MockSSTORE {

    function dummyFunction() external {
        assembly {
            sstore(25, 42)
        }
    }
}
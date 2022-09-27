// SPDX-License-Identifier: MIT License
pragma solidity ^0.8.13;

contract MockSLOAD {

    function dummyFunction() external view {
        assembly {
            let x := sload(0)
        }
    }
}
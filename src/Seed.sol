// SPDX-License-Identifier: MIT License
pragma solidity ^0.8.13;

contract Seed {

    mapping(uint256 => address) public contracts;
    uint256 counter;

    contructor() public {}

    function addContract(address memory submittedContract) public returns (bool) {
        bool allowed = gateCondition(code);

        if (allowed) {
            contracts[counter] = submittedContract;
            counter++;
        } else {
            return false;
        }
    }

    function gateCondition(address memory submittedContract) public returns (bool) {
        // Add requirements here
        return true;
    }
}
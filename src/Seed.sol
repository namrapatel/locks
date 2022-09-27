// SPDX-License-Identifier: MIT License
pragma solidity ^0.8.13;

contract Seed {

    mapping(uint256 => address) public contracts;
    uint256 counter;

    contructor() public {}

    function addContract(bytes memory code) public returns (bool) {
        bool allowed = gateCondition(code);

        if (allowed) {
            address newContract = new Contract(code);
            contracts[counter] = newContract;
            counter++;
        } else {
            return false;
        }
    }

    function gateCondition(bytes memory code) public returns (bool) {

    }

}
// SPDX-License-Identifier: MIT License
pragma solidity ^0.8.13;

contract Seed {

    mapping(uint256 => address) public contracts;
    uint256 counter;

    function addContract(address submittedContract) public returns (bool) {
        bool gatePassed = gateCondition(submittedContract);

        if (gatePassed) {
            contracts[counter] = submittedContract;
            counter++;
            return true;
        } else {
            return false;
        }
    }

    function gateCondition(address submittedContract) public view returns (bool) {
        bool opcodeExists = checkOpcodeExists(submittedContract);
        if (opcodeExists) {
            return true;
        } else {
            return false;
        }
    }

    function checkOpcodeExists(address submittedContract) public view returns (bool) {
        // Loop through all opcodes in submitted contract
        // If opcode is found, return true
        // If opcode is not found, return false
        assembly {
            let size := extcodesize(submittedContract) // Get size of submitted contract
            let ptr := mload(0x40) // Get pointer to free memory
            extcodecopy(submittedContract, ptr, 0, size) // Copy submitted contract to free memory
            let end := add(ptr, size) // Get end of submitted contract
            // Loop through all opcodes in submitted contract
            for { } lt(ptr, end) { } {
                let opcode := shr(224, mload(ptr)) // Get opcode
                // If opcode is found, return true
                if eq(opcode, 0x55) {
                    return(1, 0)
                }
                ptr := add(ptr, 1) // Increment pointer
            }
        }
        return false;
    }
}
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

library LibStorage {

    // Function that checks whether a submittedContract uses the SSTORE opcode
    function checkSSTORE(address submittedContract) public view returns (bool) {
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
                let opcode := shr(248, mload(ptr)) // Get opcode
                // If opcode is found, return true
                if eq(opcode, 0x55) {
                    mstore(0, 1) // Store 1 in memory slot 0
                    return(0, 0x20) // Return memory slot 0 with size 32 bytes
                }
                ptr := add(ptr, 1) // Increment pointer
            }
        }
        return false;
    }

    // Function that checks whether a submittedContract uses the SLOAD opcode
    function checkSLOAD(address submittedContract) public view returns (bool) {
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
                let opcode := shr(248, mload(ptr)) // Get opcode
                // If opcode is found, return true
                if eq(opcode, 0x54) {
                    mstore(0, 1) // Store 1 in memory slot 0
                    return(0, 0x20) // Return memory slot 0 with size 32 bytes
                }
                ptr := add(ptr, 1) // Increment pointer
            }
        }
        return false;
    }
}
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

library LibCall {

    // Function that checks if submittedContract uses the opcode CALL (0xF1), find address it calls, and checks if the address is in a blacklist of addresses
    function checkCall(address submittedContract, address[] memory _blacklist) public view returns (bool) {
        assembly {
            let size := extcodesize(submittedContract) // Get size of submitted contract
            let ptr := mload(0x40) // Get pointer to free memory
            extcodecopy(submittedContract, ptr, 0, size) // Copy submitted contract to free memory
            let end := add(ptr, size) // Get end of submitted contract
            // Loop through all opcodes in submitted contract
            for { } lt(ptr, end) { } {
                // Get opcode by shifting right 248 bits (31 bytes, so we get the final byte)
                let opcode := shr(248, mload(ptr)) 
                // If opcode is CALL (0xF1), check if the address it calls is in the blacklist
                if eq(opcode, 0xF1) {

                    // Set addrSearchPtr to 65 bytes before the location of the CALL opcode
                    let addrSearchPtr := sub(ptr, 0x41)
                    // Loop through all bytes until addrSearchPtr = ptr, if we find a 0x73 byte save the pointer location
                    for { } lt(addrSearchPtr, ptr) { } {
                        if eq(shr(248, mload(addrSearchPtr)), 0x73) {
                            // Get the next 20 bytes (address) from memory
                            let preShiftAddress := and(mload(add(addrSearchPtr, 1)), 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000)
                            // Shift word 12 bytes (0xC) to the right, so we store the address in the last 20 bytes of the word
                            let addressToCall := shr(96, preShiftAddress) 

                            // Loop through all addresses in blacklist
                            for { let i := 0 } lt(i, mload(_blacklist)) { i := add(i, 1) } {
                                // If address to call is in blacklist, return true
                                if eq(addressToCall, mload(add(_blacklist, mul(add(i, 1), 0x20)))) { 
                                    mstore(0, 1) // Store 1 in memory slot 0
                                    return(0, 0x20) // Return memory slot 0 with size 32 bytes
                                }
                            }
                            break
                        }
                        // Increment addrSearchPtr by 1 byte
                        addrSearchPtr := add(addrSearchPtr, 1)
                    }

                }
                ptr := add(ptr, 1) // Increment pointer
            }
        }
        return false;
    }

    
}
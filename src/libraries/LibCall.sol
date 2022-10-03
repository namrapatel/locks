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
                    // Set addrSearchPtr to 100 bytes before the location of the CALL opcode
                    let addrSearchPtr := sub(ptr, 0x64)
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

    // Function that checks if submittedContract uses the opcode CALL (0xF1), then finds the address and function signature related to the CALL and checks them against a blacklist
    function checkCallAndFunction(address submittedContract, address[] memory _blacklist, uint8[] memory functionsPerAddr, bytes4[] memory _functionBlacklist) public view returns (bool) {
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
                    // Set addrSearchPtr to 175 bytes before the location of the CALL opcode
                    let addrSearchPtr := sub(ptr, 0xAF)
                    let addrIndex := 0
                    // Loop through all bytes until addrSearchPtr = ptr, if we find a 0x73 byte save the pointer location
                    for { } lt(addrSearchPtr, ptr) { } {
                        if eq(shr(248, mload(addrSearchPtr)), 0x73) {
                            // Get the next 20 bytes (address) from memory
                            let preShiftAddress := and(mload(add(addrSearchPtr, 1)), 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000)
                            // Shift word 12 bytes (0xC) to the right, so we store the address in the last 20 bytes of the word
                            let addressToCall := shr(96, preShiftAddress) 

                            let addrFound := 0
                            // Loop through all addresses in _blacklist and find the index of the address we are looking for in _blacklist
                            for { let i := 0 } lt(i, mload(_blacklist)) { i := add(i, 1) } {
                                // If address to call is in _blacklist, set address index to i
                                if eq(addressToCall, mload(add(_blacklist, mul(add(i, 1), 0x20)))) { 
                                    addrIndex := i
                                    addrFound := 1
                                    break
                                }
                            }

                            // If address is not in _blacklist, break
                            if eq(addrFound, 0) { break }

                            // Loop through elements in functionsPerAddr until addrIndex = mload(functionsPerAddr[i])
                            let bytes4IndexesToSkip := 0
                            let indexToEndAt := 0
                            for { let i := 0 } lt(i, addrIndex) { i := add(i, 1) } {
                                // Add the number at functionsPerAddr[i] to bytes4IndexesToSkip
                                bytes4IndexesToSkip := add(bytes4IndexesToSkip, mload(add(functionsPerAddr, mul(add(i, 1), 0x20))))
                                // Store the number at functionsPerAddr[i] in indexToEndAt
                                indexToEndAt := mload(add(functionsPerAddr, mul(add(i, 1), 0x20)))
                            }

                            // Loop over the next 100 (0x64) bytes until a PUSH4 (0x63) byte is found
                            let functionSearchPtr := addrSearchPtr
                            let functionSearchEndPtr := add(addrSearchPtr, 0x64)
                            for { } lt(functionSearchPtr, functionSearchEndPtr) { } {
                                // If we find a 0x63 byte, get the next 4 bytes (function signature)
                                if eq(shr(248, mload(functionSearchPtr)), 0x63) {
                                    let preShiftFuncSig := and(mload(add(functionSearchPtr, 1)), 0xFFFFFFFF00000000000000000000000000000000000000000000000000000000)
                                    // shift word 28 bytes (0x1C) to the right, so we store the function signature in the last 4 bytes of the word
                                    let functionSig := shr(224, preShiftFuncSig)
                                    // Get the opcode 6 bytes after the 0x63 byte
                                    let opcodeAfterPush4 := shr(248, mload(add(functionSearchPtr, 6)))
                                    // shift left preShiftFuncsig by opcode2
                                    let funcSig := shl(opcodeAfterPush4, functionSig)

                                    // Loop through all function signatures in _functionBlacklist, skipping the first bytes4IndexesToSkip function signatures
                                    // and stop checking at indexToEndAt
                                    for { let i := bytes4IndexesToSkip } lt(i, add(bytes4IndexesToSkip, indexToEndAt)) { i := add(i, 1) } {
                                        // If function signature is in _functionBlacklist, return true
                                        if eq(funcSig, mload(add(_functionBlacklist, mul(add(i, 1), 0x20)))) { 
                                            mstore(0, 1) // Store 1 in memory slot 0
                                            return(0, 0x20) // Return memory slot 0 with size 32 bytes
                                        }
                                    }




                                    // for { let j := bytes4IndexesToSkip } lt(j, add(bytes4IndexesToSkip, mload(functionsPerAddr))) { j := add(j, 1) } { 
                                    //     // If function signature is in _functionBlacklist, return true
                                    //     if eq(funcSig, mload(add(_functionBlacklist, mul(add(j, 1), 0x20)))) { 
                                    //         mstore(0, 1) // Store 1 in memory slot 0
                                    //         return(0, 0x20) // Return memory slot 0 with size 32 bytes
                                    //     }
                                    // }
                                    // break
                                }
                                // Increment functionSearchPtr by 1 byte
                                functionSearchPtr := add(functionSearchPtr, 1)
                            }
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

    function checkCallTest(address submittedContract) public view returns(bytes memory) {
        return submittedContract.code;
    }

}
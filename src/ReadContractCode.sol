// SPDX-License-Identifier: MIT License
pragma solidity ^0.8.13;

import "./DummyContract.sol";

contract ReadContractCode {
    
    DummyContract dummyContract;

    constructor() {
        dummyContract = new DummyContract();
    }
    
    function readCode(address _contract) external view returns (bytes memory) {
        bytes memory code;
        assembly {
            let size := extcodesize(_contract)
            code := mload(0x40)
            mstore(0x40, add(code, and(add(add(size, 0x20), 0x1f), not(0x1f))))
            mstore(code, size)
            extcodecopy(_contract, add(code, 0x20), 0, size)
        }
        return code;
    }
}
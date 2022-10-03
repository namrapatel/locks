// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract MockDelegateCall {

    address public constant CALLER = 0x6dfc34609a05bC22319fA4Cce1d1E2929548c0D7;
    address public constant CALLEE = 0xb0EdA4f836aF0F8Ca667700c42fcEFA0742ae2B5;

    function call() public payable {
        // A's storage is set, B is not modified.
        (bool success, bytes memory data) = CALLEE.delegatecall(
            abi.encodeWithSignature("fakeFunc(uint256)", 1)
        );
    }
}
// SPDX-License-Identifier: MIT License
pragma solidity ^0.8.13;

import { MockCallee } from "./MockCallee.sol";

contract MockCall6 {

    address public constant CALLER = 0x6dfc34609a05bC22319fA4Cce1d1E2929548c0D7;
    address public constant CALLEE = 0xb0EdA4f836aF0F8Ca667700c42fcEFA0742ae2B5;

    // .call() with abi.encodeCall() with 1 argument
    function call() public {
        (bool success, bytes memory data) = CALLEE.call(abi.encodeCall(
            MockCallee.niceFunc,
            (1))
        );
    }
}

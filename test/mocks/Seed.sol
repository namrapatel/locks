// SPDX-License-Identifier: MIT License
pragma solidity ^0.8.13;
import {console} from "../utils/Console.sol";
import "../../src/libraries/LibSearch.sol";

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
        bool opcodeExists = LibSearch.checkOpcodeExists(submittedContract);
        if (opcodeExists) {
            return true;
        } else {
            return false;
        }
    }
}
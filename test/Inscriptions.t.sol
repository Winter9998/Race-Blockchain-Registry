// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import {Test} from "forge-std/Test.sol";
import "forge-std/console.sol";

import "../src/RaceMarathon.sol";

contract InscriptionsTesting is Test {

    RaceMarathon marathon;
    address fuzz1 = makeAddr("AM");
    string public DEFAULT_NAME = "John Marston";
    function setUp() public {
        marathon = new RaceMarathon();
        vm.deal(fuzz1, 100 ether);
    }

    function test_RegistrationSuccessAndReturnsUint() public {
        vm.prank(fuzz1);
        marathon.Register{value : 2 ether}(DEFAULT_NAME, 19, true, 2);
        assertEq(marathon.isRegistered(fuzz1), true);
    }
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import {Test} from "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/RaceMarathon.sol";

contract InscriptionsTesting is Test {
    RaceMarathon marathon;
    address fuzz1 = makeAddr("AM");
    string public DEFAULT_NAME = "Arthur Morgan";

    function setUp() public {
        marathon = new RaceMarathon();
        vm.deal(fuzz1, 100 ether);
    }

    function registerFuzz1() public {
        vm.prank(fuzz1);
        marathon.Register{value: 2 ether}(DEFAULT_NAME, 19, true, 2);
    }

    function testRegistrationSuccessAndReturnsUint() public {
        registerFuzz1();
        assertEq(marathon.isRegistered(fuzz1), true);
        assertEq(marathon.runnersNumber(), 1);
        assertNotEq(marathon.runnersNumber(), 0);
    }

    function testUserCannotRegisterTwoTimes() public {
        registerFuzz1();
        vm.expectRevert();
        registerFuzz1();
    }

    function testUserCanCancelHisPlace() public {
        registerFuzz1();
        vm.prank(fuzz1);
        marathon.cancelRace();
        assertEq(marathon.isRegistered(fuzz1), false);
    }

    function testCallDataisReceived() public {
        // bytes memory data = abi.encodeWithSignature("setNumber(uint)", 123);
        (bool success,) = address(marathon).call{value: 3 ether}("");
        require(success, "Call to marathon contract failed");

        // Convert 3 ether to wei for comparison
        uint256 threeEtherInWei = 3 * 10 ** 18;
        assertEq(address(marathon).balance, threeEtherInWei);
    }

    function testgetFunctions() public {
        registerFuzz1();
        assertEq(marathon.getrunnersNumber(fuzz1), 1);
        console.log(marathon.getEntranceFee("Discount"), 1.5 ether);
    }
}

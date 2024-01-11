// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.15;

import {Script, console2} from "forge-std/Script.sol";
import "forge-std/console.sol";
import "../src/RaceMarathon.sol";

contract Deploy is Script {
    RaceMarathon marathon;

    function setUp() public {
        marathon = RaceMarathon(payable(0x5FbDB2315678afecb367f032d93F642f64180aa3));
    }
}

contract TestFee is Script, Deploy {
    function run() public {
        setUp();
        getFee();
    }

    function getFee() public {
        vm.startBroadcast();
        uint256 res = marathon.getEntranceFee("Discount");
        console.log(res);
        vm.stopBroadcast();
    }

    // Private key : 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
    // Public Key : 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
}

contract TestFn is Script, Deploy {
    function run() public {
        setUp();
        Register();
    }

    function Register() public {
        vm.startBroadcast();
        uint256 res = marathon.Register{value : 2 ether}("John", 19, true, 21);
        console.log(res);
        vm.stopBroadcast();
    }

    // Private key : 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
    // Public Key : 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
}

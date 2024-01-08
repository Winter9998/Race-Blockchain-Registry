// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.15;

import {Script, console2} from "forge-std/Script.sol";
import "forge-std/console.sol";
import "../src/RaceMarathon.sol";

contract DeployRace is Script {
    RaceMarathon marathon;

    function run() public {
        vm.broadcast();
        marathon = new RaceMarathon();
    }
}

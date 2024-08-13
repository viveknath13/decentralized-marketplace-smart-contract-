// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {Script, console} from "forge-std/Script.sol";
import {DecentralizedMarketplace} from "../src/MarketPlace.sol";

contract DeployScript is Script {
    DecentralizedMarketplace public deployContract;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        deployContract = new DecentralizedMarketplace();

        vm.stopBroadcast();
    }
}
//0xD2D3DDe1bb50462b285304E896C8883A209B8db6


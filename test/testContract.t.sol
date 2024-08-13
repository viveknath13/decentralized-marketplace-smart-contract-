// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {DecentralizedMarketplace } from "../src/MarketPlace.sol";

contract CounterTest is Test {
    DecentralizedMarketplace  public testMarketPlace;

    function setUp() public {
        testMarketPlace = new DecentralizedMarketplace();
        
    }

  
}

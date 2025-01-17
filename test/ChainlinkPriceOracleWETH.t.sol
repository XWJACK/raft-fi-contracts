// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import { Test } from "forge-std/Test.sol";
import { AggregatorV3Interface } from "@smartcontractkit/chainlink/interfaces/AggregatorV3Interface.sol";
import { IPriceOracle } from "../contracts/Oracles/Interfaces/IPriceOracle.sol";
import { ChainlinkPriceOracleWETH } from "../contracts/Oracles/ChainlinkPriceOracleWETH.sol";

contract ChainlinkPriceOracleWETHTest is Test {
    AggregatorV3Interface public constant aggregatorV3ETH =
        AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419);
    ChainlinkPriceOracleWETH public chainlinkPriceOracleWETH;

    function setUp() public {
        vm.createSelectFork("mainnet", 17_484_072);

        chainlinkPriceOracleWETH = new ChainlinkPriceOracleWETH(aggregatorV3ETH);
    }

    function testChainlinkWstETHPrice() public {
        vm.warp(1_686_817_367);
        IPriceOracle.PriceOracleResponse memory priceOracleResponse = chainlinkPriceOracleWETH.getPriceOracleResponse();
        assertEq(priceOracleResponse.isBrokenOrFrozen, false);
        assertEq(priceOracleResponse.priceChangeAboveMax, false);
        assertApproxEqAbs(priceOracleResponse.price, 1_635_011e15, 1e15);
    }
}

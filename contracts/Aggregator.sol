// SPDX-License-Identifier: MIT

pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import "./GovernanceAggregator.sol";
import "./PriceAggregator.sol";
import "./SwapAggregator.sol";

contract Aggregator is GovernanceAggregator, PriceAggregator, SwapAggregator {}

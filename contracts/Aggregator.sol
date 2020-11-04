// SPDX-License-Identifier: MIT

pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import "./GovernanceAggregator.sol";
import "./PriceAggregator.sol";
import "./SwapAggregator.sol";
import "./MinerAggregator.sol";
import "torn-token/contracts/ENS.sol";

contract Aggregator is EnsResolve, GovernanceAggregator, PriceAggregator, SwapAggregator, MinerAggregator {
  function miningData(
    Miner miner,
    address[] calldata instances,
    RewardSwap swap
  )
    external
    view
    returns (
      uint256[] memory _rates,
      uint256 balance,
      uint256 poolWeight
    )
  {
    _rates = minerRates(miner, instances);
    (balance, poolWeight) = swapState(swap);
  }

  function marketData(
    address[] calldata fromTokens,
    uint256[] calldata oneUnitAmounts,
    RewardSwap swap
  ) external view returns (uint256[] memory prices, uint256 balance) {
    prices = getPricesInETH(fromTokens, oneUnitAmounts);
    balance = swap.tornVirtualBalance();
  }
}

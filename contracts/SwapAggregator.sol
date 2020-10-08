// SPDX-License-Identifier: MIT

pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import "tornado-anonymity-mining/contracts/RewardSwap.sol";

contract SwapAggregator {
  function swapState(RewardSwap swap) public view returns (uint256 balance, uint256 poolWeight) {
    balance = swap.tornVirtualBalance();
    poolWeight = swap.poolWeight();
  }
}

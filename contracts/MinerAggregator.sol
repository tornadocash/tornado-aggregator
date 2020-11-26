// SPDX-License-Identifier: MIT

pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import "tornado-anonymity-mining/contracts/Miner.sol";

contract MinerAggregator {
  function minerRates(Miner miner, address[] calldata instances) public view returns (uint256[] memory _rates) {
    _rates = new uint256[](instances.length);
    for (uint256 i = 0; i < _rates.length; i++) {
      _rates[i] = miner.rates(instances[i]);
    }
  }

  function areClaimedNotes(Miner miner, bytes32[] calldata _rewardNullifiers) external view returns (bool[] memory result) {
    result = new bool[](_rewardNullifiers.length);
    for (uint256 i = 0; i < _rewardNullifiers.length; i++) {
      result[i] = miner.rewardNullifiers(_rewardNullifiers[i]);
    }
  }
}

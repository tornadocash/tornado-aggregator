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
}

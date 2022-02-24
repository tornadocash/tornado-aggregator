// SPDX-License-Identifier: MIT

pragma solidity ^0.6.12;

interface RelayerRegistry {
  function getRelayerBalance(address relayer) external view returns (uint256);

  function isRelayerRegistered(address relayer, address toResolve) external view returns (bool);
}

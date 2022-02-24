// SPDX-License-Identifier: MIT

pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import "./interfaces/ENSRegistry.sol";
import "./interfaces/ENSResolver.sol";
import "./interfaces/RelayerRegistry.sol";

struct Relayer {
  address owner;
  uint256 balance;
  bool isRegistered;
  string[20] records;
}

contract RelayerAggregator {
  ENSRegistry public constant ensRegistry = ENSRegistry(0x00000000000C2E074eC69A0dFb2997BA6C7d2e1e);
  RelayerRegistry public constant relayerRegistry = RelayerRegistry(0x58E8dCC13BE9780fC42E8723D8EaD4CF46943dF2);

  function relayersData(bytes32[] memory _relayers, bytes32[] memory _subdomains) public view returns (Relayer[] memory) {
    Relayer[] memory relayers = new Relayer[](_relayers.length);

    for (uint256 i = 0; i < _relayers.length; i++) {
      relayers[i].owner = ensRegistry.owner(_relayers[i]);
      ENSResolver resolver = ENSResolver(ensRegistry.resolver(_relayers[i]));

      for (uint256 j = 0; j < _subdomains.length; j++) {
        relayers[i].records[j] = resolver.text(_subdomains[j], "url");
      }

      relayers[i].isRegistered = relayerRegistry.isRelayerRegistered(relayers[i].owner, relayers[i].owner);
      relayers[i].balance = relayerRegistry.getRelayerBalance(relayers[i].owner);
    }
    return relayers;
  }
}

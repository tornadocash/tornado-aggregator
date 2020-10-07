// SPDX-License-Identifier: MIT

pragma solidity ^0.6.12;

interface ENS {
  function resolver(bytes32 node) external view returns (Resolver);
}

interface Resolver {
  function addr(bytes32 node) external view returns (address);
}

contract EnsResolve {
  ENS public constant Registry = ENS(0x00000000000C2E074eC69A0dFb2997BA6C7d2e1e);

  function resolve(bytes32 node) public view returns (address) {
    return Registry.resolver(node).addr(node);
  }
}

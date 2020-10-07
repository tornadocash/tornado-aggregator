// SPDX-License-Identifier: MIT

pragma solidity ^0.6.12;

contract Echoer {
  event Echo(address indexed who, bytes data);

  function echo(bytes calldata data) external {
    emit Echo(msg.sender, data);
  }
}

// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

import "torn-token/contracts/ENS.sol";

interface OneSplit {
  function getExpectedReturn(
    address fromToken,
    address destToken,
    uint256 amount,
    uint256 parts,
    uint256 flags // See contants in IOneSplit.sol
  ) external view returns (uint256 returnAmount, uint256[] memory distribution);
}

contract PriceAggregator is EnsResolve {
  bytes32 nameHash = 0xabbae16ab822a7a0970b116c997c681cea9944854b55e1c441a9a788a2c6fc20; // 1split.eth - https://etherscan.io/enslookup?q=1split.eth

  function getPricesInETH(address[] memory fromTokens, uint256[] memory oneUnitAmounts)
    public
    view
    returns (uint256[] memory prices)
  {
    OneSplit split = OneSplit(resolve(nameHash));

    prices = new uint256[](fromTokens.length);
    for (uint256 i = 0; i < fromTokens.length; i++) {
      (uint256 price, ) = split.getExpectedReturn(
        fromTokens[i],
        0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE,
        oneUnitAmounts[i],
        1,
        0
      );
      prices[i] = price;
    }
  }
}

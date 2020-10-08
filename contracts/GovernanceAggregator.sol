// SPDX-License-Identifier: MIT

pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import "tornado-governance/contracts/Governance.sol";

contract GovernanceAggregator {
  struct Proposal {
    uint256 id;
    address proposer;
    address target;
    uint256 startTime;
    uint256 endTime;
    uint256 forVotes;
    uint256 againstVotes;
    bool executed;
    bool extended;
    Governance.ProposalState state;
  }

  function getAllProposals(
    Governance governance,
    uint256 from,
    uint256 to
  ) public view returns (Proposal[] memory proposals) {
    uint256 proposalCount = governance.proposalCount();
    to = to == 0 ? proposalCount : to;
    proposals = new Proposal[](proposalCount);

    for (from; from < to; from++) {
      (
        uint256 id,
        address proposer,
        address target,
        uint256 startTime,
        uint256 endTime,
        uint256 forVotes,
        uint256 againstVotes,
        bool executed,
        bool extended
      ) = governance.proposals(from + 1);

      proposals[from] = Proposal({
        id: id,
        proposer: proposer,
        target: target,
        startTime: startTime,
        endTime: endTime,
        forVotes: forVotes,
        againstVotes: againstVotes,
        executed: executed,
        extended: extended,
        state: governance.state(id)
      });
    }
  }

  function getGovernanceBalances(Governance governance, address[] calldata accs) public view returns (uint256[] memory amounts) {
    amounts = new uint256[](accs.length);
    for (uint256 i = 0; i < accs.length; i++) {
      amounts[i] = governance.balances(accs[i]);
    }
  }
}

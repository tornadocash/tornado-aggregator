// SPDX-License-Identifier: MIT

pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import "tornado-governance/contracts/Governance.sol";

contract GovernanceAggregator {
  struct Proposal {
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

  function getAllProposals(Governance governance) public view returns (Proposal[] memory proposals) {
    proposals = new Proposal[](governance.proposalCount());

    for (uint256 i = 0; i < proposals.length; i++) {
      (
        address proposer,
        address target,
        uint256 startTime,
        uint256 endTime,
        uint256 forVotes,
        uint256 againstVotes,
        bool executed,
        bool extended
      ) = governance.proposals(i + 1);

      proposals[i] = Proposal({
        proposer: proposer,
        target: target,
        startTime: startTime,
        endTime: endTime,
        forVotes: forVotes,
        againstVotes: againstVotes,
        executed: executed,
        extended: extended,
        state: governance.state(i + 1)
      });
    }
  }

  function getGovernanceBalances(Governance governance, address[] calldata accs) public view returns (uint256[] memory amounts) {
    amounts = new uint256[](accs.length);
    for (uint256 i = 0; i < accs.length; i++) {
      amounts[i] = governance.lockedBalance(accs[i]);
    }
  }

  function getUserData(Governance governance, address account)
    public
    view
    returns (
      uint256 balance,
      uint256 latestProposalId,
      uint256 latestProposalIdState,
      uint256 timelock,
      address delegatee
    )
  {
    // Core core = Core(address(governance));
    balance = governance.lockedBalance(account);
    latestProposalId = governance.latestProposalIds(account);
    if (latestProposalId != 0) {
      latestProposalIdState = uint256(governance.state(latestProposalId));
    }
    timelock = governance.canWithdrawAfter(account);
    delegatee = governance.delegatedTo(account);
  }
}

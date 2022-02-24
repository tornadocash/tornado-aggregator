const hre = require('hardhat')
const { ethers, waffle } = hre
const { loadFixture } = waffle
const { expect } = require('chai')
const { BigNumber } = require('@ethersproject/bignumber')
const config = require('../config')
const { getSignerFromAddress, minewait } = require('./utils')

describe('Aggregator Tests', () => {
  async function fixture() {
    const [sender] = await ethers.getSigners()

    const tornWhale = await getSignerFromAddress(config.tornWhale)

    const gov = await ethers.getContractAt('Governance', config.governance)

    const tornToken = await ethers.getContractAt(
      '@openzeppelin/contracts/token/ERC20/ERC20.sol:ERC20',
      config.TORN,
    )

    // deploy Aggregator
    const AggregatorFactory = await ethers.getContractFactory('Aggregator')
    const aggregator = await AggregatorFactory.deploy()

    return {
      sender,
      tornWhale,
      gov,
      tornToken,
      aggregator,
    }
  }

  it('Should have initialized all successfully', async function () {
    const { aggregator } = await loadFixture(fixture)
    expect(aggregator.address).to.exist
  })
})

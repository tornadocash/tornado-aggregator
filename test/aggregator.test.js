const hre = require('hardhat')
const { ethers, waffle } = hre
const { loadFixture } = waffle
const { expect } = require('chai')

const namehash = require('eth-ens-namehash')

const subdomains = [
  'mainnet-tornado',
  'bsc-tornado',
  'gnosis-tornado',
  'polygon-tornado',
  'avalanche-tornado',
  'optimism-tornado',
  'arbitrum-tornado',
  'goerli-tornado',
  'gnosis-nova',
]

const relayersList = ['relayer-service.eth', 'releth.eth', 't-relay.eth', 'torn69.eth', 'defidevotee.eth']

describe('Aggregator Tests', () => {
  async function fixture() {
    const [sender] = await ethers.getSigners()

    // deploy Aggregator
    const AggregatorFactory = await ethers.getContractFactory('Aggregator')
    const aggregator = await AggregatorFactory.deploy()

    const relayerNameHashes = relayersList.map((r) => namehash.hash(r))

    return {
      sender,
      aggregator,
      relayerNameHashes,
    }
  }

  it('Should have initialized all successfully', async function () {
    const { aggregator } = await loadFixture(fixture)
    expect(aggregator.address).to.exist
  })

  it('should work', async function () {
    const { aggregator, relayerNameHashes } = await loadFixture(fixture)
    await aggregator.relayersData(relayerNameHashes, subdomains)
  })
})

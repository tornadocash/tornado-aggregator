/* global artifacts, web3, contract */
require('chai').use(require('bn-chai')(web3.utils.BN)).use(require('chai-as-promised')).should()

const { takeSnapshot, revertSnapshot } = require('../scripts/ganacheHelper')
const Echoer = artifacts.require('./Echoer.sol')

contract('Echoer', (accounts) => {
  let echoer
  let snapshotId

  before(async () => {
    echoer = await Echoer.deployed()
    snapshotId = await takeSnapshot()
  })

  describe('#echo', () => {
    it('should work', async () => {
      const data = '0xbeef'
      const { logs } = await echoer.echo(data)

      logs[0].event.should.be.equal('Echo')
      logs[0].args.who.should.be.equal(accounts[0])
      logs[0].args.data.should.be.equal(data)
    })
  })

  afterEach(async () => {
    await revertSnapshot(snapshotId.result)
    // eslint-disable-next-line require-atomic-updates
    snapshotId = await takeSnapshot()
  })
})

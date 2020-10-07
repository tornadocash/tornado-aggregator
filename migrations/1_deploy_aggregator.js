/* global artifacts */
const Aggregator = artifacts.require('Aggregator')

module.exports = function (deployer) {
  return deployer.then(async () => {
    const aggregator = await deployer.deploy(Aggregator)

    console.log('Aggregator      :', aggregator.address)
  })
}

/* global artifacts */
const Echoer = artifacts.require('Echoer')

module.exports = function (deployer) {
  return deployer.then(async () => {
    const echoer = await deployer.deploy(Echoer)

    console.log('Echoer      :', echoer.address)
  })
}

const { ethers } = require('hardhat')
const config = require('../config')

async function main() {
  const [deployer] = await ethers.getSigners()

  console.log('Deploying contracts with the account:', deployer.address)

  console.log('Account balance:', (await deployer.getBalance()).toString())

  const AggregatorFactory = await ethers.getContractFactory('Aggregator')
  const aggregator = await AggregatorFactory.deploy()

  console.log('Aggregator address:', aggregator.address)
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error)
    process.exit(1)
  })

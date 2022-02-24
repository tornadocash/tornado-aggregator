const hre = require('hardhat')
const { ethers } = hre

async function main() {
  const [deployer] = await ethers.getSigners()

  console.log('Deploying contracts with the account:', deployer.address)

  console.log('Account balance:', (await deployer.getBalance()).toString())

  const AggregatorFactory = await ethers.getContractFactory('Aggregator')
  const aggregator = await AggregatorFactory.deploy()

  console.log(' address:', aggregator.address)

  console.log('Delay before verification...')
  await new Promise((r) => setTimeout(r, 60000))

  try {
    await hre.run('verify:verify', {
      address: aggregator.address,
      constructorArguments: [],
    })
  } catch (err) {
    console.log('Verification of aggregator failed:', err.message)
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error)
    process.exit(1)
  })

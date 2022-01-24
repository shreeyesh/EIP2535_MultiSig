const MultiSigWallet = artifacts.require("MultiSigWallet")
async function deployDiamond() {
module.exports = function (deployer, network, accounts) {
  const owners = accounts.slice(0, 3)
  const numConfirmationsRequired = 2
  const accounts = await ethers.getSigners()
  deployer.deploy(MultiSigWallet, owners, numConfirmationsRequired)
  const contractOwner = await accounts[0]
  console.log(`contractOwner ${contractOwner.address}`)
}
}
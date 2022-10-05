const { ethers } = require("hardhat");
require("dotenv").config({ path: ".env" });
const { CRYPTODEVS_CONTRACT_ADDRESS } = require("../constants");

async function main() {
  // Address of the whitelist contract that you deployed in the previous module
  const CryptoDevsContract = CRYPTODEVS_CONTRACT_ADDRESS;
  // URL from where we can extract the metadata for a Crypto Dev NFT
  /*
  A ContractFactory in ethers.js is an abstraction used to deploy new smart contracts,
  so cryptoDevsContract here is a factory for instances of our CryptoDevs contract.
  */
  const cryptoDevsTokenContract = await ethers.getContractFactory(
    "CryptoDevToken"
  );

  // deploy the contract
  const deployedCryptoDevsTokenContract = await cryptoDevsTokenContract.deploy(
    CryptoDevsContract
  );

  // print the address of the deployed contract
  console.log(
    "Crypto Devs token Contract Address:",
    deployedCryptoDevsTokenContract.address
  );
}

// Call the main function and catch if there is any error
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

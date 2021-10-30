const hre = require("hardhat");

async function main() {
  // We get the contract to deploy
  const Implementation = await hre.ethers.getContractFactory("Implementation");
  const implementation = await Implementation.deploy();

  await implementation.deployed();

  console.log("Implementation deployed to:", greeter.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

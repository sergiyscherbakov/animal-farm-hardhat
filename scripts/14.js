// scripts/testAnimalFarm.js
const hre = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const Cow = await ethers.getContractFactory("Cow");
  const cow = await Cow.deploy("Bessie");
    // Чекаємо на майнінг транзакції розгортання
  console.log("Cow deployed to:", cow.target);

  const Horse = await ethers.getContractFactory("Horse");
  const horse = await Horse.deploy("Pegasus");
  console.log("Horse deployed to:", horse.target);

  const Wolf = await ethers.getContractFactory("Wolf");
  const wolf = await Wolf.deploy("Grey Wind");
  console.log("Wolf deployed to:", wolf.target);

  const Farmer = await ethers.getContractFactory("Farmer");
  const farmer = await Farmer.deploy();
  console.log("Farmer deployed to:", farmer.target);

  console.log("Calling speak on Cow and Horse:");
  console.log(await farmer.call(cow.target));
  console.log(await farmer.call(horse.target));

  console.log("Feeding Wolf with plant and meat:");
  try {
    console.log(await farmer.feed(wolf.target, "plant"));
  } catch (error) {
    console.error("Error: Wolf can't eat plant");
  }
  try {
    console.log(await farmer.feed(wolf.target, "meat"));
  } catch (error) {
    console.error("Error: Wolf can't eat meat");
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

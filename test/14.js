const { expect } = require("chai");

describe("Animal Farm", function () {
  let Cow, Horse, Wolf, Farmer, cow, horse, wolf, farmer, owner;

  beforeEach(async function () {
    [owner] = await ethers.getSigners();

    Cow = await ethers.getContractFactory("Cow");
    cow = await Cow.deploy("Bessie");

    Horse = await ethers.getContractFactory("Horse");
    horse = await Horse.deploy("Pegasus");

    Wolf = await ethers.getContractFactory("Wolf");
    wolf = await Wolf.deploy("Grey Wind");

    Farmer = await ethers.getContractFactory("Farmer");
    farmer = await Farmer.deploy();
  });

  it("should make the cow say 'Mooo'", async function () {
    expect(await farmer.call(cow.target)).to.equal("Mooo");
  });

  it("should make the horse say 'Igogo'", async function () {
    expect(await farmer.call(horse.target)).to.equal("Igogo");
  });

  it("should not allow the wolf to eat plant", async function () {
    await expect(farmer.feed(wolf.target, "plant")).to.be.revertedWith("Can only eat meat");
  });

  it("should allow the wolf to eat meat", async function () {
    expect(await farmer.feed(wolf.target, "meat")).to.equal("Animal eats meat");
  });
});

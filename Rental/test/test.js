const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Rental", function () {
  it("Should return a number", async function () {
    const CarRental = await ethers.getContractFactory("Rental");
    const carRental = await CarRental.deploy();
    let result = await carRental.checkDatabase();
    result = result.toNumber();

    expect(result).to.be.a("number");
  });
});

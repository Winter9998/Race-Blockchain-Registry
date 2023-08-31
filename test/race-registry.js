const { ethers } = require("hardhat");
const { expect } = require("chai");

describe("Inscriptions", function () {
  
  let Inscriptions;
  let inscriptions;
  let owner;

  beforeEach(async function() {
    Inscriptions = await ethers.getContractFactory("Inscriptions");
    inscriptions = await Inscriptions.deploy();
    [owner] = await ethers.getSigners();
  });

  it("Should pay the fee", async function (){
    await inscriptions.Pay(owner.address, 19);
    await owner.sendTransaction({
      to: inscriptions.address,
      value: ethers.parseEther('2')

    });
    await Pay.wait();



  });
  
  it("Should register for a new runner", async function(){
    const hasPaid = await inscriptions.hasPaid(owner.address); // Accessing mapping as if it were a function
    expect(hasPaid).to.equal(true); // Or whatever the expected value is
    
    await inscriptions.Register("Ali", 19, true, 2);
  

    const isRegistered = await inscriptions.isRegistered("Ali");
    expect(isRegistered).to.equal(true);
  });
});

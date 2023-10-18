import { ethers } from "hardhat";
import { DeployFunction } from "hardhat-deploy/dist/types";
import { HardhatRuntimeEnvironment } from "hardhat/types";

const func: DeployFunction = async ({
    deployments,
    ethers,
  }: HardhatRuntimeEnvironment) => {
    const {deploy} = deployments;
    const accounts = await ethers.getSigners();

    const deployer = accounts[0];
  
    // deploy library
    const library = await deploy('Perpustakaan', {
      contract: 'Perpustakaan',
      from: deployer.address,
      args: [],
      gasLimit: 1000000,
    });
    console.log("Perpustakaan deployed at ", library.address);
  };

  func.tags = ['perpustakaan'];

  export default func;
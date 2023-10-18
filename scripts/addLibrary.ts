import { link } from "fs";
import { Perpustakaan } from "../src/types";
import { ethers } from "hardhat";

async function main() {
    // contract instance
    const library = await ethers.getContract<Perpustakaan>("Perpustakaan");

    // const [owner, perpustakaan] = await ethers.getSigners();

    let bookLenght = await library.getLibraryLength();
    console.log("bookLength=", Number(bookLenght));
    
    // get signers
    const [owner, isbn1] = await ethers.getSigners();

    // add book
    const addLibrary = await library.connect(owner).Library(isbn1.address, 'Mahen', 'Programmer');
    await addLibrary.wait();

    bookLenght = await library.getLibraryLength();
    console.log("bookLength=", Number(bookLenght));

    const bookDetail = await library.getBookByISBN(isbn1.address);
    console.log("booksDetail", bookDetail);
}

main().catch((err) =>{
    console.log("error=", err);
    process.exitCode = 1;
})
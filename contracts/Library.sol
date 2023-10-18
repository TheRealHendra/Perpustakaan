// SPDX-License-Identifier: MIT

pragma solidity 0.8.13;

contract Perpustakaan {
    struct Book {
        string judul;
        uint256 tahunDibuat;
        string penulis;
    }

    // Mapping untuk ISBN ke buku
    mapping(string => Book) private books;

    // Mapping untuk admin
    mapping(address => bool) private admins;

    // Konstruktor, menambahkan alamat admin saat kontrak dibuat
    constructor() {
        admins[msg.sender] = true;
    }

    // Modifikasi untuk memeriksa apakah pemanggil adalah admin
    modifier onlyAdmin() {
        require(admins[msg.sender], "Hanya admin yang dapat mengakses fungsi ini");
        _;
    }

    // Fungsi untuk menambahkan buku baru
    function tambahBuku(string memory _isbn, string memory _judul, uint256 _tahunDibuat, string memory _penulis) public onlyAdmin {
        // Pastikan ISBN belum ada
        require(bytes(books[_isbn].judul).length == 0, "Buku dengan ISBN ini sudah terdaftar");

        // Tambahkan buku baru
        books[_isbn] = Book(_judul, _tahunDibuat, _penulis);
    }

    // Fungsi untuk memperbarui buku berdasarkan ISBN
    function updateBook(string memory _isbn, string memory _judul, uint256 _tahunDibuat, string memory _penulis) public onlyAdmin {
        // Pastikan buku dengan ISBN ini ada
        require(bytes(books[_isbn].judul).length > 0, "Buku dengan ISBN ini tidak terdaftar");

        // Perbarui buku
        books[_isbn] = Book(_judul, _tahunDibuat, _penulis);
    }

    // Fungsi untuk menghapus buku berdasarkan ISBN
    function hapusBuku(string memory _isbn) public onlyAdmin {
        // Pastikan buku dengan ISBN ini ada
        require(bytes(books[_isbn].judul).length > 0, "Buku dengan ISBN ini tidak terdaftar");

        // Hapus buku
        delete books[_isbn];
    }

    // Fungsi untuk mendapatkan data buku berdasarkan ISBN
    function cariBuku(string memory _isbn) public view returns (string memory, uint256, string memory) {
        // Pastikan buku dengan ISBN ini ada
        require(bytes(books[_isbn].judul).length > 0, "Buku dengan ISBN ini tidak terdaftar");

        // Ambil data buku
        Book memory book = books[_isbn];
        return (book.judul, book.tahunDibuat, book.penulis);
    }

    // Fungsi untuk menambahkan admin baru
    function tambahAdmin(address _admin) public onlyAdmin {
        admins[_admin] = true;
    }

    // Fungsi untuk menghapus admin
    function hapusAdmin(address _admin) public onlyAdmin {
        admins[_admin] = false;
    }
}
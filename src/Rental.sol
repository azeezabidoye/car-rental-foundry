// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract CarRental {
    // Declare the owner of contract
    address owner;

    // Constructor
    constructor() {
        owner = msg.sender;
    }

    // Add yourself as a Renter
    struct Renter {
        address payable walletAddress;
        string firstname;
        string lastname;
        bool canRent;
        bool isActive;
        uint balance;
        uint due;
        uint start;
        uint end;
    }

    // Mapping Wallet addresses to Renters
    mapping(address => Renter) public renters;
}

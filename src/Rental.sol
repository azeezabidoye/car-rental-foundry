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

    // Function for adding a new Renter
    function addRenter(
        address payable walletAddress,
        string memory firstname,
        string memory lastname,
        bool canRent,
        bool isActive,
        uint balance,
        uint due,
        uint start,
        uint end
    ) public {
        renters[walletAddress] = Renter(
            walletAddress,
            firstname,
            lastname,
            canRent,
            isActive,
            balance,
            due,
            start,
            end
        );
    }

    // Check out car
    function checkOut(address payable walletAddress) public {
        renters[walletAddress].isActive = false;
        renters[walletAddress].canRent = true;
        renters[walletAddress].start = block.timestamp;
    }

    // Check in car
    function checkIn(address payable walletAddress) public {
        renters[walletAddress].isActive = true;
        renters[walletAddress].canRent = false;
        renters[walletAddress].start = block.timestamp;

        // TO DO: Add Due Amount
    }

    // Function to calculate Timespan
    function renterTimespan(uint end, uint start) internal pure returns (uint) {
        return end - start;
    }
}

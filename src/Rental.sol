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

        // Set Due Amount
        setAmountDue(walletAddress);
    }

    // Function to calculate Timespan
    function renterTimespan(uint end, uint start) internal pure returns (uint) {
        return end - start;
    }

    // Get total duration of rent time
    function getTotalDuration(
        address payable walletAddress
    ) public view returns (uint) {
        uint timeDuration = renterTimespan(
            renters[walletAddress].end,
            renters[walletAddress].start
        );
        uint timespanToMimutes = timeDuration / 60;
        return timespanToMimutes;
    }

    // Get contract balance
    function balanceOf() public view returns (uint) {
        return address(this).balance;
    }

    // Get Renter's balance
    function getRenterBalance(
        address payable walletAddress
    ) public view returns (uint) {
        return renters[walletAddress].balance;
    }

    // Set Due amount
    function setAmountDue(address payable walletAddress) internal {
        uint timespanMinutes = getTotalDuration(walletAddress);
        uint fiveMinuteIncrement = timespanMinutes / 5;
        renters[walletAddress].due = fiveMinuteIncrement * 50000000000000000;
    }

    // Reset Rental Option
    function canRentBike(
        address payable walletAddress
    ) public view returns (bool) {
        return renters[walletAddress].canRent;
    }
}

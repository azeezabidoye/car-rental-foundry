// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract CarRental {
    // Declare the owner of contract
    address owner;

    // Constructor
    constructor() {
        owner = msg.sender;
    }
}

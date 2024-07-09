// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract endChallenge
 {

    uint256 public balance;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // Event to be emitted when funds are deposited
    event Deposit(address indexed sender, uint256 amount);

    // Event to be emitted when funds are withdrawn
    event Withdraw(address indexed receiver, uint256 amount);

    // Function to deposit funds into the contract
    function deposit() public payable {
        require(msg.value > 0, "Please deposit amount whih is greater than zero ");
        balance += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    // Function to withdraw funds from the contract
    function withdraw(uint256 amount) public {
        require(msg.sender == owner, "Are you the owner? only owner can withdraw funds");
        require(amount <= balance, "The balance is insufficient");

        // Decrease balance before transferring to prevent reentrancy attacks
        balance -= amount;

        // Transfer the specified amount to the caller
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");

        emit Withdraw(msg.sender, amount);
    }

    // Function to trigger an assertion failure
    function triggerAssert() public view {
        assert(balance >= 0); // This should always be true
    }

    // Function to trigger a revert
    function triggerRevert() public pure {
        revert("This function always reverts");
    }
}

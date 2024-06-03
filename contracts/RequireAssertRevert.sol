pragma solidity ^0.8.0;

contract RequireAssertRevert {

    uint256 public balance;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function deposit(uint256 amount) public payable {
        require(msg.value == amount, "Incorrect amount sent.");
        balance += amount;
    }

    function withdraw(uint256 amount) public {
        require(msg.sender == owner, "Only the owner can withdraw funds.");
        require(amount <= balance, "Insufficient balance.");
        
        balance -= amount;
        payable(msg.sender).transfer(amount);
    }

    function transferOwnership(address newOwner) public {
        require(msg.sender == owner, "Only the owner can transfer ownership.");
        assert(newOwner != address(0));
        owner = newOwner;
    }

    function testRevert() public pure {
        revert("This function always reverts.");
    }
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CryptoLocker {
    mapping(address => uint) public balances;
    mapping(address => uint) public unlockTime;

    function deposit(uint _timeInSeconds) public payable {
        require(msg.value > 0, "Kindly send some Ether");
        balances[msg.sender] = msg.value;
        unlockTime[msg.sender] = block.timestamp + _timeInSeconds;
    }

    function withdraw() public {
        require(block.timestamp >= unlockTime[msg.sender], "Funds are still locked, try again after sometime");
        require(balances[msg.sender] > 0, "No balance to withdraw, check again");

        uint amount = balances[msg.sender];
        balances[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }
}

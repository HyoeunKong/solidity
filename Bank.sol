pragma solidity ^0.5.8;

contract Bank{
    
    uint public totalDeposit;
    mapping(address => uint) balanceOf;
    address dev1;
    address dev2;
    constructor() public {
    
    }

    function deposit() public payable{ //돈을 받을 수 있는 함수
        balanceOf[msg.sender] += msg.value; 
        totalDeposit += msg.value;
  
    }
    
     function withdraw(uint _amount) public payable {
        balanceOf[msg.sender] -= _amount;
        totalDeposit -= _amount;
        msg.sender.transfer(_amount);
    }

    function getBalanceOf(address _account) public view returns (uint){ 
        return balanceOf[_account];
    }
}
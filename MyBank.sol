pragma solidity ^0.5.8;

contract SimpleToken {
    address payable owner;
    
    string symbol = "STK";
    
    mapping(address => uint) public balanceOf;
    
    constructor() public payable{
        balanceOf[msg.sender] = 100000000000000000;
        owner = msg.sender;
    }
    
    function transfer(address _to, uint _value) public {
        address _from = msg.sender;
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
    }
    
    function buy () public payable{
        uint stk = msg.value * 10;
        balanceOf[msg.sender] += stk;
        balanceOf[owner] -= stk;
        owner.transfer(msg.value);
        
    } 
    
    function sell (uint _amount) public payable{
        uint money = _amount / 10;
        balanceOf[msg.sender] -= _amount;
        balanceOf[owner] += _amount;
        msg.sender.transfer(money);
    }
    
}
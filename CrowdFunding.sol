pragma solidity ^0.5.8;
contract CrowdFunding {
    
    struct Investor{
        address payable addr;
        uint amount;
    }
    
    mapping(uint => Investor) public investors;
    uint numOfInvestors;
    uint public goalAmount = 10000000000;
    uint public totalAmount;
    address payable owner;
    
    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
        
    }
    constructor() payable public{
        owner = msg.sender;
        numOfInvestors = 0;
        
    }
    function func() public payable {
        //msg.sender , msg.value
        // => Investor()
        // => investors
        // totalAmount += msg.value;
        investors[numOfInvestors]=Investor(msg.sender, msg.value);
        totalAmount += msg.value;
    }
    
    function checkGoalFunding() public payable onlyOwner {
        if(totalAmount >= goalAmount){
         owner.transfer(address(this).balance);
         totalAmount = 0;
        }else{
           for(uint i = 0; i < numOfInvestors ; i++ ){
           investors[i].addr.transfer(investors[i].amount);
           
        }
        totalAmount = 0;
    }
}
    function killcontract() public onlyOwner{
        
    }
}
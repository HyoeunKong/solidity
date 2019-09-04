pragma solidity ^0.5.8;

contract Lottery {
// 응모자를 관리하는 매핑
	mapping (uint => address) public applicants;

	// 응모자 수
	uint public numApplicants;
//
	// 당첨자 정보
	address public winnerAddress;
	uint public winnerId;
	
	// 소유자
	address public owner;

	// 타임스탬프
	uint public timestamp;
	
	/// 소유자 여부를 확인하는 modifier
	modifier onlyOwner() {
		require(msg.sender == owner);
		_;
	}

    constructor() public payable{
        numApplicants = 0;
        owner = msg.sender;
        
    }

    function addNum() public{
     for(uint i = 0; i < numApplicants; i++ ){
         require(applicants[i] != msg.sender);
     }
     applicants[numApplicants++] = msg.sender;
    
    } 

    function hold() public onlyOwner {
        timestamp = block.timestamp;
        winnerId = timestamp % numApplicants;

       winnerAddress = applicants[winnerId];


    }
      
}
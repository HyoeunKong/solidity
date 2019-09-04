pragma solidity ^0.5.8;

//duplicate => bool(vote)
//add candidate => ownerOnly

contract Vote {
    uint8 numOfCandidate = 0;
    mapping(address => bool) isVoted;
    mapping(string => uint )score;
    mapping(uint8 => string)candidateList; //후보자 리스트
    address payable owner;
    // 후보자 리스트
    // 각 후보자별 득표수
    constructor () public {
        owner = msg.sender;
    }
    
    modifier ownerOnly(){
        require(msg.sender == owner);
        _;
    }
    
    modifier checkDuplicate(){
          require(isVoted[msg.sender] == false);
          _;
    }
    
    function addCandidate(string memory candidate) public ownerOnly {
        bool found = false;
        for (uint8 i = 0; i < numOfCandidate; i++){
            if(keccak256(bytes(candidateList[i])) == keccak256(bytes(candidate))){
                found = true;
                break;
            }
        }
        require(!found);
        candidateList[numOfCandidate] = candidate;
        numOfCandidate ++;

    }

    function vote (string memory candidate) public checkDuplicate {
      
        score[candidate] ++;
        isVoted[msg.sender] = true;

    }

    function getNumOfCandidate() public view returns (uint8) {
        return numOfCandidate;
    }

    function getCandidate(uint8 index) public view returns (string memory) {
        return candidateList[index];
    }
    
    function getScore(string memory candidate) public view returns (uint) {
        return score[candidate];

    }
    
    //destroy contract
    function killContract() public ownerOnly{
        selfdestruct(owner);
        
    }
}
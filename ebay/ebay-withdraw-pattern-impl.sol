pragma solidity ^0.4.4;

//implement the withdrawl pattern
contract ebayWithdraw {
    
    mapping(address => uint) internal pendingWithdrawals;
    
    function withdraw() public returns (bool) {
        uint amount = pendingWithdrawals[msg.sender];
        if(amount > 0) {
            pendingWithdrawals[msg.sender] = 0; //update actor state            
            if (!msg.sender.send(amount))  //is transfer successful?
			{
                //roll-back
                pendingWithdrawals[msg.sender] = amount;
                return false;
            }
        }
        return true;
    }
}
pragma solidity ^0.4.4;

import "./ebay-Interface.sol";

//contract for auction owner
contract ebayBase is ebayInterface {
    
    address public owner;
    
    modifier ownerOnly(){
        require(msg.sender == owner);
        _;
    }
    
	//event to announce the winner at the end of the auction
    event AuctionComplete(address winner, uint bid);

    function ebayBase(){
        owner = msg.sender;
    }
}
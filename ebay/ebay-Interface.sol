pragma solidity ^0.4.4;

//ebay interface for bidders
interface Auction {
    
	//accept bid
    function bid() public payable;
    
    //end auction 
    function end() public;
}
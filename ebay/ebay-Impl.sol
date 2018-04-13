pragma solidity ^0.4.4;

import "./ebay-base-Impl.sol";
import "./ebay-withdraw-pattern-impl.sol";

contract ebayAuction is ebayBase, ebayWithdraw {
    
    uint public auctionEnd;
    string public item;
    address public maxBidder;
    uint public maxBid;
    bool public ended;
    
    event BidAccepted(address bidder, uint bid);
    
	//define item & duration to start the auction
    function ebayAuction(string _item, uint _durationMinutes) {
        item = _item;
        auctionEnd = now + (_durationMinutes * 1 minutes);
    }
    
    function bid() public payable {
        //make sure auction hasnt already ended
        require(now < auctionEnd);
        //make sure bid is higher than current max
        require(msg.value > maxBid);
        
        //return the bid amount that got beat
        if(maxBidder != 0){
            //allow the beaten bidder to withdraw ether safely
            pendingWithdrawals[maxBidder] += maxBid;
        }
        
        maxBidder = msg.sender;
        maxBid = msg.value;
        BidAccepted(maxBidder, maxBid);
    }
    
    function end() public ownerOnly {
        //make sure owner cant declare winner before time is up
        require(now >= auctionEnd);
		
        //make sure this function only called once
        require(!ended);
    
        //set the flag
        ended = true;
		
        //announce the winner
        AuctionComplete(maxBidder, maxBid);
        
        //allow owner to withdraw 
        pendingWithdrawals[owner] += maxBid;
    }
}
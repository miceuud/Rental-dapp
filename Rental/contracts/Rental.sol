// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract CarRental {
  // Global variables
  uint totalAvailableCars;
  address rentalOwner; 
  bool rented;
   
  struct Renters {
    address renter; 
    uint index;
  }
  // rentals storage
  Renters[] public renters;

  event RentalIsSuccefull (address, string);
  error PendingRentalReturn(address, string );
  error RentalNotAvailable (string);

  constructor() {
    rentalOwner = msg.sender;
    totalAvailableCars = 10;
  }

  modifier isOwner() {
    require(msg.sender == rentalOwner, "Only rental owner can perform this action");
    _;
  }
// Check rental DB for admin
function checkDatabase() public isOwner view returns( Renters[] memory) {
    return renters;  
     

}
// request rental
function requestARental (uint index) public  { 

  for ( uint i = 0; i < renters.length; i++) {
    if(msg.sender == renters[i].renter ) revert PendingRentalReturn(msg.sender, "You are yet to returned previous rental"); 
  }
  // require( req ==  1, "You can only rent one per time");
  // check availability
  if(totalAvailableCars == 0 ) revert RentalNotAvailable("No rental available at this time");

  totalAvailableCars -= 1;  
  renters.push(Renters(msg.sender,index));
  emit RentalIsSuccefull(msg.sender, "You have successfully rented a car");
}
// rental return
function returnRental () public  {  
  // check if address rented a car
  for (uint i = 0; i < renters.length ; i++) {
      if(renters[i].renter == msg.sender) {
        totalAvailableCars += 1;
        renters[i] = renters[renters.length - 1];
         renters.pop();
         emit RentalIsSuccefull(msg.sender, "You have successfully returned your rental"); 
      } else {
         revert PendingRentalReturn(msg.sender, "No pending rental found");
      }    
}
// rental fee withdraw 
function withdraw () public {
    require(msg.sender == rentalOwner, "Only service owner can perform this action" );
    payable(msg.sender).transfer(address(this).balance);
  }
}
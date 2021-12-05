// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Rental {
  uint totalAvailableCars;
  address rentalOwner; 
  address[] renters;
  bool rented;
  uint[] carIndex;

  event RentalIsSuccefull (address, string);
  error PendingRentalReturn(address, string );
  error RentalNotAvailable (string);

  constructor() {
    rentalOwner = msg.sender;
    // fixed number of cars
    totalAvailableCars = 10;
  }

   modifier isOwner() {
    require(msg.sender == rentalOwner, "Only rental owner can perform this action");
    _;
  }
  // Check rental DB
  function checkDatabase() public isOwner view returns(uint) {
      return totalAvailableCars;
        // renters,
  }
  function getOwner() public isOwner view returns(address) {
      return rentalOwner;
        // renters,
  }
    

  function requestARental ( uint req, address _address) public  { 
  
    //address can only rent if there are no pending returns
    for (uint256 index = 0; index < renters.length; index++) {
      if(renters[index] == _address) {
        revert PendingRentalReturn(msg.sender, "You are yet to returned previous rental");
      } 
    }
    // check availability
      if(totalAvailableCars == 0 ) revert RentalNotAvailable("No rental available at this time");
      // approve rental
      totalAvailableCars -= 1;  
      renters.push(_address);
      carIndex.push(req);
      emit RentalIsSuccefull(msg.sender, "You have successfully rented a car");
    }

  function returnRental (uint index, address _address) public  {  
    // check if address rented a car
      for (uint i = 0; i < renters.length; i++) {
        if(_address == renters[i]) {
          totalAvailableCars += 1;
          delete renters[i]; 
          
        if(carIndex[i] == index) delete carIndex[i];
           /* fix the emmpty index */
          emit RentalIsSuccefull(msg.sender, "You have successfully returned your rental");
        } else {
          revert PendingRentalReturn(msg.sender, "No pending rental found");     
        }
      
      }
    }
    // function getMyRentals () public views returns(uint) {

    // }
    // function getAllRentals () public views isOwner returns(uint) {

    // }
}
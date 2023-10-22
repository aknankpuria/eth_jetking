// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract lottery {

           address public manager;
        //    address of the manager

        address[] public  participants;


           constructor(){
             manager = msg.sender;

           }
           

        function entry() public payable {
            // function to enter the lottery

         require(msg.value > 0.02 ether , "minimum price is 0.02 eth");
         participants.push(msg.sender);

        }

        function random() private view returns (uint256){
            // function to generate a random number to PICK WINNER.

         return uint256(keccak256(abi.encodePacked(block.difficulty, block.timestamp , participants)));

        }

        function pickwinner( ) public restricted {
            // function to pick the winner
           
           require(participants.length > 0 , "no participants in the lottery");
         
           uint256 index = random() % participants.length ;
           address winner = participants[index];
           payable (winner).transfer(address(this).balance);


           participants = new address[](0);
        //    reseting the participant array for new round 
        }

        modifier restricted(){
           require(msg.sender == manager , "Only the manager can choose winner / can call this function");
           _;

        }

        function getParticipants( ) public view returns (address[] memory){

            return participants;
        }
}
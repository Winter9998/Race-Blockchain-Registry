/*

███╗░░░███╗░█████╗░██████╗░░█████╗░████████╗██╗░░██╗░█████╗░███╗░░██╗
████╗░████║██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██║░░██║██╔══██╗████╗░██║
██╔████╔██║███████║██████╔╝███████║░░░██║░░░███████║██║░░██║██╔██╗██║
██║╚██╔╝██║██╔══██║██╔══██╗██╔══██║░░░██║░░░██╔══██║██║░░██║██║╚████║
██║░╚═╝░██║██║░░██║██║░░██║██║░░██║░░░██║░░░██║░░██║╚█████╔╝██║░╚███║
╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░╚═╝░╚════╝░╚═╝░░╚══╝
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

/// @dev Custom errors for better readability.
error ErrorTerminate (string message);
error Unauthorized();
error DepositMinorUnsuccessful(uint personAge);

/// @title Inscriptions Contract
/// @dev Contract to manage runner registrations for various races. 
/// @author FrostX.eth
contract RaceMarathon {
    

    /// @dev Data structure to store information about a runner.
    struct Runner {
    string name;
    uint age;
    bool license;
    RaceType raceType;
    uint raceIndex;
    address addr;
    }

    /// @dev Enumeration for different types of races.
    enum RaceType {
    Race1,
    Race2,
    Race3,
    Race4
    }

    mapping (address => bool) public isRegistered;
    Runner[] public runners;
    uint public raceIndex;
    uint public runnersNumber = 0;
    uint public constant REQUIRED_ETHER = 2 ether;
    uint public constant REQUIRED_ETHER_DISCOUNT =  1.5 ether; /// @dev Discount for minors.
    RaceType public raceType;



    /// @notice Function to register a new runner.
    /// @param _name The name of the runner.
    /// @param _age The age of the runner.
    /// @param _license Whether the runner has a license.
    /// @param _typeRace The type of race the runner is registering for.
    /// @return The total number of registered runners.
    function Register(string memory _name, uint _age, bool _license, uint _typeRace) payable public returns(uint){
    if (_age < 18 ){ if (msg.value != REQUIRED_ETHER_DISCOUNT) revert DepositMinorUnsuccessful(_age);
    } else { if (msg.value != REQUIRED_ETHER) revert DepositMinorUnsuccessful(_age);}

    // Convert _typeRace to the corresponding enum value based on its integer value
    if (_typeRace == 1) {
        raceType = RaceType.Race1;
        raceIndex = 10;
    } else if (_typeRace == 2) {
        raceType = RaceType.Race2;
        raceIndex = 12;
    } else if (_typeRace == 3) {
        raceType = RaceType.Race3;
        raceIndex = 21;
    } else if (_typeRace == 4) {
        raceType = RaceType.Race4;
        raceIndex = 42;
    } else {
        revert();
    }

    runners.push(Runner(_name, _age, _license, raceType, raceIndex, msg.sender));
    isRegistered[msg.sender] = true;

    runnersNumber++;
    return runnersNumber;

    }








    /// @dev Receive and fallback function to accept incoming payments.
    receive() external payable {}
    fallback() external payable {}

}
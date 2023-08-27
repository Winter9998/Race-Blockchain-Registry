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

contract Inscriptions {
    /// @title Inscriptions Contract
    /// @dev Contract to manage runner registrations for various races. 
    /// @author FrostX.eth

    /// @dev Data structure to store information about a runner.
    struct Runner {
    string name;
    uint age;
    string license;
    RaceType raceType;
    uint raceIndex;
    address addr;
}

    /// @dev Mapping to store the registration status of each address.
    mapping (address => bool) public isRegistered;

    //  mapping (string => bool) isMinor;

    /// @dev Mapping to store the payment status of each address.
    mapping (address => bool) hasPaid;

    /// @dev Enumeration for different types of races.
    enum RaceType {
    Race1,
    Race2,
    Race3,
    Race4
}

/// @dev Array to hold all registered runners.
Runner[] public runners;

 /// @dev Index for the race.
uint public raceIndex;

/// @dev Count of registered runners.
uint public runnersNumber = 0; 

 /// @dev Amount of ether required for registration.
 uint public constant REQUIRED_ETHER = 2000000000000000000;

/// @dev Discounted amount of ether required for minors.
uint public constant REQUIRED_ETHER_DISCOUNT =  1500000000000000000;

/// @notice Function to register a new runner.
    /// @param _name The name of the runner.
    /// @param _age The age of the runner.
    /// @param _license Whether the runner has a license.
    /// @param _typeRace The type of race the runner is registering for.
    /// @param _addr The address of the runner.
    /// @return The total number of registered runners.
function Register(string memory _name, uint _age, bool _license, uint _typeRace, address _addr) public returns(uint){
    
    require(hasPaid[_addr], "Cannot Register if the fee has not been paid yet");
    
    RaceType raceType;

    string memory licenseValidation;

    if (_license){

        licenseValidation = "yes";
    } else {
        licenseValidation = "no";
    }
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

    runners.push(Runner(_name, _age, licenseValidation , raceType, raceIndex, _addr));
    isRegistered[_addr] = true;

    runnersNumber++;
    return runnersNumber;

}

/// @notice Function to handle the payment for registration.
    /// @dev Pay the registration fee. The fee depends on the age of the runner.
    /// @param _addr The address making the payment.
    /// @param _age The age of the person making the payment.

    function Pay(address _addr, int _age) public payable {
       uint requiredPayment = _age >= 18 ? REQUIRED_ETHER : REQUIRED_ETHER_DISCOUNT;
        if (hasPaid[_addr] || msg.value != requiredPayment){
            revert();
        }

        hasPaid[_addr] = true;

       
    }

    /// @dev Receive and fallback function to accept incoming payments.
    receive() external payable {}
    fallback() external payable {}

}
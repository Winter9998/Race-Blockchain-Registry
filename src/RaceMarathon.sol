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
    uint runnerNumber;
    }

    /// @dev Enumeration for different types of races.
    enum RaceType {
    Race10,
    Race12,
    Race21,
    Race42
    }

    event RunnerRegistered( 
        string _name,
        uint _age,
        bool _license,
        uint _typeRace
    );

    RaceType public raceType;
    mapping (address => bool) public isRegistered;
    mapping (address => uint) public runnerNumber;
    mapping (address => Runner[]) public runners;
    uint public runnersNumber = 0;
    uint public immutable REQUIRED_ETHER = 2 ether;
    uint public immutable REQUIRED_ETHER_DISCOUNT =  1.5 ether; /// @dev Discount for minors.

    /// @dev Receive and fallback function to accept incoming payments.
    receive() external payable {}
    fallback() external payable {}

    /// @notice Function to register a new runner.
    /// @param _name The name of the runner.
    /// @param _age The age of the runner.
    /// @param _license Whether the runner has a license.
    /// @param _typeRace The type of race the runner is registering for.
    /// @return The total number of registered runners.
    function Register(
        string memory _name,
        uint _age,
        bool _license,
        uint _typeRace
        ) public payable returns(uint){
    
    require(!isRegistered[msg.sender], "Cannot register a second time");

    if (_age < 18 ){ 
        if (msg.value != REQUIRED_ETHER_DISCOUNT) revert DepositMinorUnsuccessful(_age);
    } else {
        if (msg.value != REQUIRED_ETHER) revert DepositMinorUnsuccessful(_age);}

    // Convert _typeRace to the corresponding enum value based on its integer value
    if (_typeRace == 1){
        raceType = RaceType.Race10;
    } else if (_typeRace == 2){
        raceType = RaceType.Race12;
    } else if (_typeRace == 3){
        raceType = RaceType.Race21;
    } else if (_typeRace == 4){
        raceType = RaceType.Race42;
    } else {
        revert();
    }

    Runner memory newRunner = Runner(_name, _age, _license, raceType, runnersNumber);
    runners[msg.sender].push(newRunner);

    runnersNumber++;
    runnerNumber[msg.sender] = runnersNumber;
    isRegistered[msg.sender] = true;
    
    emit RunnerRegistered(_name, _age, _license, _typeRace);
    return runnersNumber;
    }

    function cancelRace() public {
        require(isRegistered[msg.sender], "Unable to process Cancellation");
        delete runners[msg.sender];
        delete isRegistered[msg.sender];
    }

    function getrunnersNumber() public view returns(uint){
        return runnersNumber;
    }

    function getEntranceFee(string memory _type) public pure returns(uint){
        if (keccak256(abi.encodePacked(_type)) == keccak256(abi.encodePacked("Normal"))){
            return REQUIRED_ETHER;
        } else if(keccak256(abi.encodePacked(_type)) == keccak256(abi.encodePacked("Discount"))){
            return REQUIRED_ETHER_DISCOUNT;
        } else {
            return 1;
        }
    }

    function getRunnersArray(uint256 index) public view {

    }
    


}
# Inscriptions Smart Contract

[![Inscriptions ASCII Art](https://textart4u.blogspot.com/2012/08/joker-face-ascii-text-art.html)]
> The Inscriptions contract is designed to manage race registrations, payments, and various functionalities around it.

## Table of Contents

- [Getting Started](#getting-started)
- [Prerequisites](#prerequisites)
- [Deployment](#deployment)
- [Functions](#functions)
- [Constant Variables](#constant-variables)
- [State Variables](#state-variables)
- [Errors](#errors)
- [Authors](#authors)
- [License](#license)

## Getting Started

To clone and run this application, you'll need [Git](https://git-scm.com), [Node.js](https://nodejs.org/en/download/) and [Hardhat](https://hardhat.org/getting-started/#overview) installed on your computer. From your command line:

```bash
# Clone this repository
$ git clone <repository_link>

# Go into the repository
$ cd <repository_name>

# Install dependencies
$ npm install
Prerequisites
Solidity ^0.8.9
Hardhat
Node.js and npm
Deployment
To deploy this contract, use Hardhat:

bash
Copy code
npx hardhat run scripts/deploy.js --network <network-name>
Functions
Register
Allows users to register for a race. Requires the payment fee to be paid first.

Pay
Allows users to pay the race fee. The fee varies depending on age.

receive
Fallback receive function for receiving Ether.

fallback
Fallback function for the contract.

Constant Variables
REQUIRED_ETHER
REQUIRED_ETHER_DISCOUNT
State Variables
isRegistered
isMinor
hasPaid

Enums
RaceType

Errors
ErrorTerminate
Unauthorized

Authors
FrostX.eth

License
This project is licensed under the MIT License.
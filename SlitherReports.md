Smart Contract Audit Report for Inscriptions.sol
Introduction
The smart contract Inscriptions.sol aims to handle registrations for various races. The contract has functions to register participants, pay fees, and other related functionalities.

Methodology
Static analysis of the smart contract code was conducted using the tool Slither to identify security vulnerabilities, code quality issues, and optimization opportunities.

Findings
1. Contract Locking Ether
Issue: The contract contains payable functions but lacks a function to withdraw the ether.
Location: contracts/Inscriptions.sol#87-96, #98, #99
Severity: Critical
Recommendation: Implement a secure withdraw function to allow withdrawal of ether.
Reference: Contracts that lock ether

2. Uninitialized Local Variables
Issue: Local variable raceType is declared but never initialized.
Location: contracts/Inscriptions.sol#49
Severity: Major
Recommendation: Initialize the variable or remove it if unnecessary.
Reference: Uninitialized local variables

3. Incorrect Solidity Version
Issue: Pragma version allows older, non-recommended versions of the compiler.
Location: contracts/Inscriptions.sol#12
Severity: Minor
Recommendation: Update to a more recent and recommended version of Solidity.
Reference: Incorrect versions of Solidity

4. Naming Conventions
Issue: Several function names and parameters do not adhere to Solidity naming conventions.
Location: contracts/Inscriptions.sol#45-82, #87-96
Severity: Minor
Recommendation: Rename the functions and parameters to be in mixedCase.
Reference: Conformance to Solidity naming conventions

5. Literals with Too Many Digits
Issue: Literals with too many digits make the code less readable.
Location: contracts/Inscriptions.sol#84, #85
Severity: Minor
Recommendation: Use constants for these values for better readability.
Reference: Too many digits

6. Unused State Variable
Issue: The state variable isMinor is declared but never used.
Location: contracts/Inscriptions.sol#30
Severity: Minor
Recommendation: Remove the variable if it's not needed.
Reference: Unused state variable

Conclusion
The smart contract has a range of issues that need attention, including critical security flaws. Addressing these issues will not only make the contract safer but also easier to manage and upgrade.

Appendix
Raw output from Slither is used for this report.
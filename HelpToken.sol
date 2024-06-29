// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract HelpToken is ERC20, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    event HelpRequested(address indexed receiver, address indexed requester);

    constructor(address defaultAdmin, address minter) ERC20("HelpToken", "HPT") {
        _grantRole(DEFAULT_ADMIN_ROLE, defaultAdmin);
        _grantRole(MINTER_ROLE, minter);
    }

    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        _mint(to, amount);
    }

    function requestOneHelp() public {
        _burn(_msgSender(), 1);
        emit HelpRequested(_msgSender(), _msgSender());
    }

    function requestOneHelpFrom(address _account) public {
        _spendAllowance(_account, _msgSender(), 1);
        _burn(_account, 1);
        emit HelpRequested(_msgSender(), _account);
    }
}
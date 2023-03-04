// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import "../../../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract StableCoin is ERC20 {
    constructor() ERC20("FuturoStable", "FTS") {
        // mint 10,000 tokens with 18 decimals
        _mint(msg.sender, 10000 * (10**18));
    }

    function mint(address account, uint256 amount) external {
        _mint(account, amount);
    }
}

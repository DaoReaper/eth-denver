// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "node_modules/@openzeppelin/contracts/proxy/Clones.sol";
import {ERC20} from "node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Reaper} from "contracts/Reaper.sol";
import {IInitData} from "contracts/interfaces/IInitData.sol";

contract ReaperFactory is IInitData {
    address public reaperSingleton;

    ERC20 public linkToken = ERC20(0x326C977E6efc84E512bB9C30f76E30c160eD06FB);

    ERC20 public testToken = ERC20(0xA49dF10dD5B84257dE634F4350218f615471Fc69);

    uint256 private linkDeposit = 10 * 1e18; // 10 LINK

    event newReaper(address reaper);

    constructor() {
        reaperSingleton = address(new Reaper());
    }

    function deployReaper(InitData calldata initData)
        external
        returns (address)
    {
        address clone = Clones.clone(reaperSingleton);

        Reaper(clone).initialize(initData);

        require(_fundLinkDeposit(clone), "Missing LINK deposit!");

        emit newReaper(clone);

        return clone;
    }

    function _fundLinkDeposit(address reaperClone) internal returns (bool) {
        return testToken.transferFrom(msg.sender, reaperClone, linkDeposit);
    }
}

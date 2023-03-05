// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/proxy/Clones.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Reaper} from "./Reaper.sol";
import {IInitData} from "./interfaces/IInitData.sol";
import {ReaperConsumer} from "./ReaperConsumer.sol";

contract ReaperFactory is IInitData {
    address public reaperSingleton;

    address public reaperConsumer = 0xeA6721aC65BCeD841B8ec3fc5fEdeA6141a0aDE4; // Mumbai

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

        // address chainlinkConsumer = address(new ReaperConsumer(reaperConsumer));

        address chainlinkConsumer = address(11);

        Reaper(clone).initialize(initData, chainlinkConsumer);

        // ReaperConsumer(chainlinkConsumer).init(clone);

        require(_fundLinkDeposit(address(this)), "Missing LINK deposit!");

        emit newReaper(clone);

        return clone;
    }

    function _fundLinkDeposit(address sponsor) internal returns (bool) {
        return testToken.transferFrom(msg.sender, sponsor, linkDeposit);
    }
}

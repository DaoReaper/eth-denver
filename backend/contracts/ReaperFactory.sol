// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/proxy/Clones.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Reaper} from "./Reaper.sol";
import {IInitData} from "./interfaces/IInitData.sol";
import {ReaperConsumer} from "./chainlink/ReaperConsumer.sol";
import {ReaperRoleModifier} from "./zodiac-mod-roles/ReaperRoleModifier.sol";
import {Roles} from "./zodiac-mod-roles/Roles.sol";
import {IBaal} from "./interfaces/IBaal.sol";

contract ReaperFactory is IInitData {
    address public reaperSingleton;
    address public reaperRoleModSingleton;
    address public roles;

    address public reaperConsumerMumbai =
        0xa1F4E605585D8e7a3160938Cbe873D03525a95d8; // Mumbai
    address public reaperConsumerGoerli =
        0x9106E3FeB7a83C090D324460f487b09F773C1C99; // Goerli

    ERC20 public linkToken = ERC20(0x326C977E6efc84E512bB9C30f76E30c160eD06FB); // LINK

    ERC20 public testToken = ERC20(0xA49dF10dD5B84257dE634F4350218f615471Fc69); // FTR

    uint256 private linkDeposit = 1 * 1e18; // 1 LINK

    event newReaper(address reaper);

    constructor() {
        reaperSingleton = address(new Reaper());
        reaperRoleModSingleton = address(new ReaperRoleModifier());
        roles = address(new Roles());
    }

    function deployReaper(InitData calldata initData)
        external
        returns (address)
    {
        // deploy Reaper clone
        address clone = Clones.clone(reaperSingleton);

        Reaper(clone).initialize(initData, reaperConsumerGoerli);

        // link cloned Reaper to ChainlinkConsumer contract, this is commented out bc testing on Goerli, Chainlink is only on Mumbai
        // ReaperConsumer(chainlinkConsumer).init(clone);

        // fund the factory with LINK to pay for Chainlink subscriptions
        // require(_fundLinkDeposit(address(this)), "Missing LINK deposit!");

        emit newReaper(clone);

        return clone;
    }

    function deployReaperWithRoleModifier(InitData calldata initData)
        external
        returns (address)
    {
        IBaal baal = IBaal(initData.baalDao);
        address avatar = baal.avatar();

        // deploy Roles
        address rolesClone = Clones.clone(roles);

        Roles(roles).initialize(address(baal), avatar, avatar);

        // deploy Reaper clone
        address clone = Clones.clone(reaperRoleModSingleton);

        ReaperRoleModifier(clone).initialize(
            initData,
            reaperConsumerGoerli,
            roles
        );

        // fund the factory with LINK to pay for Chainlink subscriptions
        require(_fundLinkDeposit(address(this)), "Missing LINK deposit!");

        emit newReaper(clone);

        return clone;
    }

    function _fundLinkDeposit(address sponsor) internal returns (bool) {
        return testToken.transferFrom(msg.sender, sponsor, linkDeposit);
    }
}

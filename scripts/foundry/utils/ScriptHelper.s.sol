// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "lib/forge-std/src/Script.sol";
import {IAvatar} from "node_modules/@gnosis.pm/zodiac/contracts/interfaces/IAvatar.sol";
import {ERC20} from "node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ReaperFactory} from "contracts/ReaperFactory.sol";
import {Reaper} from "contracts/Reaper.sol";
import {IBaal} from "contracts/interfaces/IBaal.sol";
import {IInitData} from "contracts/interfaces/IInitData.sol";

// BROADCAST
// forge script scripts/foundry/utils/ScriptHelper.s.sol:ScriptHelperScript --rpc-url $RU --private-key $PK --broadcast --verify --etherscan-api-key $EK -vvvv

// SIMULATE
// forge script scripts/foundry/utils/ScriptHelper.s.sol:ScriptHelperScript --rpc-url $RU --private-key $PK -vvvv

contract ScriptHelper is Script, IInitData {
    ReaperFactory public factory;
    Reaper public reaper;
    InitData initData;

    // Baal DAO and Avatar (treasury) address
    IBaal public baal = IBaal(0xB0E6081785E339e0F7b8627d1820f7CCC316A03a);
    IAvatar public avatar = IAvatar(baal.avatar());

    // LINK deposit
    ERC20 public linkToken = ERC20(0x326C977E6efc84E512bB9C30f76E30c160eD06FB);
    ERC20 public testToken = ERC20(0xA49dF10dD5B84257dE634F4350218f615471Fc69);
    uint256 public linkDeposit = (10 * 10e18); // 10 LINK

    // Liquidation asset and target
    ERC20 public testLiquidationAsset =
        ERC20(0xbA7c8D4A583375a3104f251BF40AbD5ff2953E30);
    address public testLiquidationTarget =
        0xa25256073cB38b8CAF83b208949E7f746f3BEBDc;

    // Reaper analysis interval
    uint256 testInterval = 1 minutes;

    // deploy ReaperFactory
    function setUpFactory() public {
        factory = new ReaperFactory();
    }

    // configure initialization data
    function configureInitData(
        address dao,
        address asset,
        address target,
        uint256 interval,
        bool repuatationMode
    ) public {
        initData.baalDao = dao;
        initData.liquidationAsset = asset;
        initData.liquidationTarget = target;
        initData.interval = interval;
        initData.reputationReaper = repuatationMode;
    }
}

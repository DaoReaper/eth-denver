// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "../../../lib/forge-std/src/Script.sol";
import {IAvatar} from "../../../node_modules/@gnosis.pm/zodiac/contracts/interfaces/IAvatar.sol";
import {ERC20} from "../../../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ReaperFactory} from "../../../contracts/ReaperFactory.sol";
import {Reaper} from "../../../contracts/Reaper.sol";
import {IBaal} from "../../../contracts/interfaces/IBaal.sol";
import {IInitData} from "../../../contracts/interfaces/IInitData.sol";

// BROADCAST
// forge script scripts/foundry/utils/ScriptHelper.s.sol:ScriptHelper --rpc-url $RU --private-key $PK --broadcast --verify --etherscan-api-key $EK -vvvv

// SIMULATE
// forge script scripts/foundry/utils/ScriptHelper.s.sol:ScriptHelper --rpc-url $RU --private-key $PK -vvvv

contract ScriptHelper is Script, IInitData {
    ReaperFactory public factory;
    Reaper public reaper;
    InitData initData;

    // Baal DAO and Avatar (treasury) address
    IBaal public baal = IBaal(0x695Fbfe5271fb2a00dD31019f8Dc9404b08898d1);
    IAvatar public avatar = IAvatar(baal.avatar());

    // LINK deposit
    uint256 public deposit = 1e18; // 1 token

    // ERCO20 tokens
    // ERC20 public linkToken = ERC20(0x326C977E6efc84E512bB9C30f76E30c160eD06FB); // LINK (MUMBAI)
    ERC20 public cowToken = ERC20(0x91056D4A53E1faa1A84306D4deAEc71085394bC8); // COW
    ERC20 public futuroToken =
        ERC20(0xA49dF10dD5B84257dE634F4350218f615471Fc69); // FTR
    ERC20 public futuroStableToken =
        ERC20(0xbA7c8D4A583375a3104f251BF40AbD5ff2953E30); // FTS
    ERC20 public usdc = ERC20(0xD87Ba7A50B2E7E660f678A895E4B72E7CB4CCd9C); // USDC

    // ERCO20 tokens array
    address[] erc20s = [
        address(cowToken),
        address(futuroToken),
        address(futuroStableToken),
        address(usdc)
    ];

    // Liquidation asset and target
    address public testLiquidationTarget =
        0xD5d1bb95259Fe2c5a84da04D1Aa682C71A1B8C0E;

    // Reaper analysis interval
    uint256 testInterval = 1 seconds;

    uint256 threshold = 70;

    // deploy ReaperFactory
    function setUpFactory() public {
        factory = new ReaperFactory();
    }

    // configure initialization data
    function configureInitData(
        address _dao,
        address _target,
        uint256 _interval,
        uint256 _threshold
    ) public {
        initData.baalDao = _dao;
        initData.liquidationTarget = _target;
        initData.interval = _interval;
        initData.threshold = _threshold;
    }

    function fundSafeEther() public {
        (bool success, ) = address(avatar).call{value: 0.05 ether}("");
        require(success, "Ether not received!");
    }

    function fundSafeErc20() public {
        // require(
        //     _fundLinkDeposit(cowToken, address(avatar), deposit * 5),
        //     "Missing LINK deposit!"
        // );
        require(
            _fundLinkDeposit(futuroToken, address(avatar), deposit * 10),
            "Missing FTR deposit!"
        );
        require(
            _fundLinkDeposit(futuroStableToken, address(avatar), deposit * 10),
            "Missing FTS deposit!"
        );
        // require(
        //     _fundLinkDeposit(usdc, address(avatar), deposit * 12),
        //     "Missing USDC deposit!"
        // );
    }

    function _fundLinkDeposit(
        ERC20 token,
        address recipient,
        uint256 amount
    ) public returns (bool) {
        return token.transfer(recipient, amount);
    }
}

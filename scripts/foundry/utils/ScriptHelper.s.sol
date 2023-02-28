// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "lib/forge-std/src/Script.sol";
import {ReaperFactory} from "contracts/ReaperFactory.sol";
import {Reaper} from "contracts/Reaper.sol";
import {IBaal} from "contracts/interfaces/IBaal.sol";
import {IInitData} from "contracts/interfaces/IInitData.sol";

// BROADCAST
// forge script scripts/foundry/ScriptHelper.s.sol:ScriptHelperScript --rpc-url $RU --private-key $PK --broadcast --verify --etherscan-api-key $EK -vvvv

// SIMULATE
// forge script scripts/foundry/ScriptHelper.s.sol:ScriptHelperScript --rpc-url $RU --private-key $PK -vvvv

contract ScriptHelper is Script, IInitData {
    ReaperFactory public factory;
    Reaper public reaper;
    InitData initData;

    // Baal DAO and Avatar (treasury) address
    IBaal public baal = IBaal(0xe6A491f18f366AAcf6145830271009B5689373DB);
    address public avatar = baal.avatar();

    // deploy ReaperFactory
    function setUpFactory() public {
        factory = new ReaperFactory();
    }

    // configure initialization data
    function configureInitData(address dao, uint256 interval) public {
        initData.baalDao = dao;
        initData.interval = interval;
    }
}

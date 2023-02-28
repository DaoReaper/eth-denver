// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {ScriptHelper} from "scripts/foundry/utils/ScriptHelper.s.sol";
import {Reaper} from "contracts/Reaper.sol";

// BROADCAST
// forge script scripts/foundry/ProposeShaman.s.sol:ProposeShamanScript --rpc-url $RU --private-key $PK --broadcast --verify --etherscan-api-key $EK -vvvv

// SIMULATE
// forge script scripts/foundry/ProposeShaman.s.sol:ProposeShamanScript --rpc-url $RU --private-key $PK -vvvv

contract ProposeShamanScript is ScriptHelper {
    function run() public {
        vm.startBroadcast();

        setUpFactory();

        configureInitData(address(baal), 30 days);

        reaper = Reaper(factory.deployReaper(initData));

        vm.stopBroadcast();
    }
}

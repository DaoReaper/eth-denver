// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {ScriptHelper} from "./utils/ScriptHelper.s.sol";
import {Reaper} from "../../contracts/Reaper.sol";

// BROADCAST
// forge script scripts/foundry/ReaperInitiation.s.sol:ReaperInitiationScript --rpc-url $RU --private-key $PK --broadcast --verify --etherscan-api-key $EK -vvvv

// SIMULATE
// forge script scripts/foundry/ReaperInitiation.s.sol:ReaperInitiationScript --rpc-url $RU --private-key $PK -vvvv

contract ReaperInitiationScript is ScriptHelper {
    function run() public {
        vm.startBroadcast();

        setUpFactory();

        configureInitData(
            address(baal),
            testLiquidationTarget,
            testInterval,
            threshold
        );

        testToken.approve(address(factory), linkDeposit);

        reaper = Reaper(factory.deployReaper(initData));

        fundSafe();

        vm.stopBroadcast();
    }
}

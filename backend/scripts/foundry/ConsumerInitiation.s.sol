// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {ScriptHelper} from "./utils/ScriptHelper.s.sol";
import {Reaper} from "../../contracts/Reaper.sol";
import {ReaperConsumer} from "../../contracts/ReaperConsumer.sol";

// BROADCAST
// forge script scripts/foundry/ConsumerInitiation.s.sol:ConsumerInitiation --rpc-url $RUM --private-key $PKM --broadcast --verify --etherscan-api-key $EK -vvvv
// forge script scripts/foundry/ConsumerInitiation.s.sol:ConsumerInitiation --rpc-url $RU --private-key $PK --broadcast --verify --etherscan-api-key $EK -vvvv

// SIMULATE
// forge script scripts/foundry/ConsumerInitiation.s.sol:ConsumerInitiation --rpc-url $RUM --private-key $PKM -vvvv
// forge script scripts/foundry/ConsumerInitiation.s.sol:ConsumerInitiation --rpc-url $RU --private-key $PK -vvvv

contract ConsumerInitiation is ScriptHelper {
    address public reaperConsumer = 0xeA6721aC65BCeD841B8ec3fc5fEdeA6141a0aDE4; // Mumbai

    function run() public {
        vm.startBroadcast();
        // new Reaper();
        new ReaperConsumer(reaperConsumer);

        // setUpFactory();

        // configureInitData(
        //     address(baal),
        //     address(testLiquidationAsset),
        //     testLiquidationTarget,
        //     testInterval,
        //     threshold
        // );

        // testToken.approve(address(factory), linkDeposit);

        // reaper = Reaper(factory.deployReaper(initData));

        // fundSafe();

        vm.stopBroadcast();
    }
}

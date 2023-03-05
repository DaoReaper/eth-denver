// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "../../lib/forge-std/src/Script.sol";
import {ReaperConsumer} from "../../contracts/chainlink/ReaperConsumer.sol";

// BROADCAST
// forge script scripts/foundry/DeployConsumer.s.sol:DeployConsumerScript --rpc-url $RU --private-key $PK --broadcast --verify --etherscan-api-key $EK -vvvv

// SIMULATE
// forge script scripts/foundry/DeployConsumer.s.sol:DeployConsumerScript --rpc-url $RU --private-key $PK -vvvv

contract DeployConsumerScript is Script {
    address oracleAddress = 0xeA6721aC65BCeD841B8ec3fc5fEdeA6141a0aDE4;

    function run() public {
        vm.startBroadcast();

        new ReaperConsumer(oracleAddress);

        vm.stopBroadcast();
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "../../lib/forge-std/src/Script.sol";
import {ReaperFactory} from "../../contracts/ReaperFactory.sol";

// BROADCAST
// forge script scripts/foundry/DeployFactory.s.sol:DeployFactoryScript --rpc-url $RU --private-key $PK --broadcast --verify --etherscan-api-key $EK -vvvv

// SIMULATE
// forge script scripts/foundry/DeployFactory.s.sol:DeployFactoryScript --rpc-url $RU --private-key $PK -vvvv

contract DeployFactoryScript is Script {
    function run() public {
        vm.startBroadcast();

        new ReaperFactory();

        vm.stopBroadcast();
    }
}

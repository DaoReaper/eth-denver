// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "lib/forge-std/src/Script.sol";
import {StableCoin} from "scripts/foundry/test/StableCoin.sol";

// BROADCAST
// forge script scripts/foundry/test/DeployToken.s.sol:DeployTokenScript --rpc-url $RU --private-key $PK --broadcast --verify --etherscan-api-key $EK -vvvv

// SIMULATE
// forge script scripts/foundry/test/DeployToken.s.sol:DeployTokenScript --rpc-url $RU --private-key $PK -vvvv

contract DeployTokenScript is Script {
    function run() public {
        vm.startBroadcast();

        new StableCoin();

        vm.stopBroadcast();
    }
}

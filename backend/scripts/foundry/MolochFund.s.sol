// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {ScriptHelper} from "./utils/ScriptHelper.s.sol";
import {Reaper} from "../../contracts/Reaper.sol";

// BROADCAST
// forge script scripts/foundry/MolochFund.s.sol:MolochFundScript --rpc-url $RU --private-key $PK --broadcast --verify --etherscan-api-key $EK -vvvv

// SIMULATE
// forge script scripts/foundry/MolochFund.s.sol:MolochFundScript --rpc-url $RU --private-key $PK -vvvv

contract MolochFundScript is ScriptHelper {
    function run() public {
        vm.startBroadcast();

        fundSafeEther();

        fundSafeErc20();

        vm.stopBroadcast();
    }
}

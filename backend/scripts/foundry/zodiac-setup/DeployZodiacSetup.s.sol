// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {ScriptHelper} from "../utils/ScriptHelper.s.sol";
import {Roles} from "../../../contracts/zodiac-mod-roles/Roles.sol";
import {Permissions} from "../../../contracts/zodiac-mod-roles/Permissions.sol";

// BROADCAST
// forge script scripts/foundry/zodiac-setup/DeployZodiacSetup.s.sol:DeployZodiacSetupScript --rpc-url $RU --private-key $PK --broadcast --verify --etherscan-api-key $EK -vvvv

// SIMULATE
// forge script scripts/foundry/zodiac-setup/DeployZodiacSetup.s.sol:DeployZodiacSetupScript --rpc-url $RU --private-key $PK -vvvv

contract DeployZodiacSetupScript is ScriptHelper {
    Roles public roles;

    function run() public {
        vm.startBroadcast();

        // args: owner, safe, target of exec functions
        roles = new Roles();
        roles.initialize(address(baal), address(avatar), address(avatar));

        vm.stopBroadcast();
    }
}

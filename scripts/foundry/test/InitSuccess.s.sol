// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "lib/forge-std/src/Script.sol";
import {IAvatar} from "node_modules/@gnosis.pm/zodiac/contracts/interfaces/IAvatar.sol";
import {Reaper} from "contracts/Reaper.sol";
import {IBaal} from "contracts/interfaces/IBaal.sol";

// BROADCAST
// forge script scripts/foundry/test/InitSuccess.s.sol:InitSuccessScript --rpc-url $RU --private-key $PK --broadcast --verify --etherscan-api-key $EK -vvvv

// SIMULATE
// forge script scripts/foundry/test/InitSuccess.s.sol:InitSuccessScript --rpc-url $RU --private-key $PK -vvvv

contract InitSuccessScript is Script {
    Reaper public reaper = Reaper(0x7a9B785aDcA22ED15dFFaED5ef13D61C0524Ee38);

    // Baal DAO and Avatar (treasury) address
    IBaal public baal = IBaal(0xe6A491f18f366AAcf6145830271009B5689373DB);
    IAvatar public avatar = IAvatar(baal.avatar());

    function isModule() internal returns (bool) {
        return avatar.isModuleEnabled(address(reaper));
    }

    function isShaman() internal returns (bool) {
        return baal.isManager(address(reaper));
    }

    function run() public {
        vm.startBroadcast();

        isModule();

        isShaman();

        vm.stopBroadcast();
    }
}

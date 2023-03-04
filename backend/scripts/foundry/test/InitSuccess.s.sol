// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "../../../lib/forge-std/src/Script.sol";
import {IAvatar} from "../../../node_modules/@gnosis.pm/zodiac/contracts/interfaces/IAvatar.sol";
import {Reaper} from "../../../contracts/Reaper.sol";
import {IBaal} from "../../../contracts/interfaces/IBaal.sol";

// BROADCAST
// forge script scripts/foundry/test/InitSuccess.s.sol:InitSuccessScript --rpc-url $RU --private-key $PK --broadcast -vvvv

// SIMULATE
// forge script scripts/foundry/test/InitSuccess.s.sol:InitSuccessScript --rpc-url $RU --private-key $PK -vvvv

contract InitSuccessScript is Script {
    Reaper public reaper = Reaper(0xE2F1F9798E03C94b685a0597046aad702DbA7ACE);

    // Baal DAO and Avatar (treasury) address
    IBaal public baal = IBaal(0xB0E6081785E339e0F7b8627d1820f7CCC316A03a);
    IAvatar public avatar = IAvatar(baal.avatar());

    function isModule() internal view returns (bool) {
        return avatar.isModuleEnabled(address(reaper));
    }

    function isShaman() internal view returns (bool) {
        return baal.isManager(address(reaper));
    }

    function run() public {
        vm.startBroadcast();

        require(isModule(), "Not Module!");

        require(isShaman(), "Not Shaman!");

        vm.stopBroadcast();
    }
}

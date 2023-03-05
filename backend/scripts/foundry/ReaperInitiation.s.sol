// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {ScriptHelper} from "./utils/ScriptHelper.s.sol";
import {ReaperFactory} from "../../contracts/ReaperFactory.sol";
import {Reaper} from "../../contracts/Reaper.sol";

// BROADCAST
// forge script scripts/foundry/ReaperInitiation.s.sol:ReaperInitiationScript --rpc-url $RU --private-key $PK --broadcast --verify --etherscan-api-key $EK -vvvv

// SIMULATE
// forge script scripts/foundry/ReaperInitiation.s.sol:ReaperInitiationScript --rpc-url $RU --private-key $PK -vvvv

contract ReaperInitiationScript is ScriptHelper {
    function run() public {
        vm.startBroadcast();

        setUpFactory();
        // factory = ReaperFactory(0x7b17360FA0F295011649FC32ACd292BB98A76f0C);

        configureInitData(
            address(baal),
            testLiquidationTarget,
            testInterval,
            threshold
        );

        // testing with arbitray ERC20. use LINK in production
        futuroToken.approve(address(factory), deposit);

        reaper = Reaper(factory.deployReaper(initData));

        reaper.addSafeHoldings(erc20s);

        vm.stopBroadcast();
    }
}

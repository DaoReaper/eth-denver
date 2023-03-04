// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "lib/forge-std/src/Script.sol";
import {ERC20} from "node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ICoWSwapEthFlow, EthFlowOrder} from "contracts/legacy/ICoWSwapEthFlow.sol";

// BROADCAST
// forge script scripts/foundry/test/CowEthFlow.s.sol:CowEthFlow --rpc-url $RU --private-key $PK --broadcast --verify --etherscan-api-key $EK -vvvv

// SIMULATE
// forge script scripts/foundry/test/CowEthFlow.s.sol:CowEthFlow --rpc-url $RU --private-key $PK -vvvv

contract CowEthFlow is Script {
    // CoW Protocol
    ICoWSwapEthFlow public constant cowSwapEthFlow =
        ICoWSwapEthFlow(0x40A50cf069e992AA4536211B23F286eF88752187);

    EthFlowOrder.Data ethFlowOrder;

    function swapAssets() public {
        bytes32 data;

        // todo: convert Ether to stable coin
        ethFlowOrder.buyToken = ERC20(
            0x91056D4A53E1faa1A84306D4deAEc71085394bC8
        );
        ethFlowOrder.receiver = address(this);
        ethFlowOrder.sellAmount = address(this).balance;
        ethFlowOrder.buyAmount = 1 ether;
        ethFlowOrder.appData = data;
        ethFlowOrder.feeAmount = 1;
        ethFlowOrder.validTo = uint32(block.timestamp + (60 * 60));
        ethFlowOrder.partiallyFillable = true;
        ethFlowOrder.quoteId = 198145;

        cowSwapEthFlow.createOrder(ethFlowOrder);
    }

    function fund() public {
        (bool success, ) = address(this).call{value: 0.05 ether}("");
        require(success, "Ether not received!");
    }

    function run() public {
        vm.startBroadcast();

        fund();

        swapAssets();

        vm.stopBroadcast();
    }
}

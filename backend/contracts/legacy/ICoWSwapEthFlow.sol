// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {IERC20} from "../../node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";

library EthFlowOrder {
    struct Data {
        /// @dev The address of the token that should be bought for ETH. It follows the same format as in the CoW Swap
        /// contracts, meaning that the token GPv2Transfer.BUY_ETH_ADDRESS (0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE)
        /// represents native ETH (and should most likely not be used in this context).
        IERC20 buyToken;
        /// @dev The address that should receive the proceeds from the order. Note that using the address
        /// GPv2Order.RECEIVER_SAME_AS_OWNER (i.e., the zero address) as the receiver is not allowed.
        address receiver;
        /// @dev The exact amount of ETH that should be sold in this order.
        uint256 sellAmount;
        /// @dev The minimum amount of buyToken that should be received to settle this order.
        uint256 buyAmount;
        /// @dev Extra data to include in the order. It is used by the CoW Swap infrastructure as extra information on
        /// the order and has no direct effect on on-chain execution.
        bytes32 appData;
        /// @dev The exact amount of ETH that should be paid by the user to the CoW Swap contract after the order is
        /// settled.
        uint256 feeAmount;
        /// @dev The last timestamp in seconds from which the order can be settled (order cannot resolve after this timestamp).
        uint32 validTo;
        /// @dev Flag indicating whether the order is fill-or-kill or can be filled partially.
        bool partiallyFillable;
        /// @dev quoteId The quote id obtained from the CoW Swap API to lock in the current price. It is not directly
        /// used by any onchain component but is part of the information emitted onchain on order creation and may be
        /// required for an order to be automatically picked up by the CoW Swap orderbook.
        int64 quoteId;
    }
}

interface ICoWSwapEthFlow {
    function createOrder(EthFlowOrder.Data calldata order)
        external
        payable
        returns (bytes32 orderHash);
}

// 0x37c5b029f9c3691b3d47cb024f84e5e257aeb0bb.createOrder
// (order = {"buyToken":"0x91056d4a53e1faa1a84306d4deaec71085394bc8","receiver":"0x37c5b029f9c3691b3d47cb024f84e5e257aeb0bb","sellAmount":"999999133013329213","buyAmount":"4694053363558763553812","appData":"0x3f1aabaf92e2f1cdd097c8712ef50a412c7e37e28ac7d08c63b9eba3d64f2b8d","feeAmount":"866986670787","validTo":1677806927,"partiallyFillable":false,"quoteId":198144})
// =>
// (0x3f0b7903630adca249699fcf03f486e119ea1ae2b6dd10c32f3f644d62664036)

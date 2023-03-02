// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface IInitData {
    /**
     * baalDao - address of Baal DAO
     * liquidationAsset - ERC20 stable coin to consolidate liquidation (e.g. USDC)
     * liquidationTarget - public good where liquidation fund is sent (e.g. Giveth)
     * interval - time interval at which Reaper can make analysis
     */
    struct InitData {
        address baalDao;
        address liquidationAsset;
        address liquidationTarget;
        uint256 interval;
        bool reputationReaper;
    }
}

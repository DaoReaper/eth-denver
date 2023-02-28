// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface IInitData {
    struct InitData {
        address baalDao; // address of Baal DAO
        uint256 interval; // time interval at which Reaper can make analysis
    }
}

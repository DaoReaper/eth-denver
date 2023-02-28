// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "node_modules/@openzeppelin/contracts/proxy/Clones.sol";
import {Reaper} from "contracts/Reaper.sol";
import {IInitData} from "contracts/interfaces/IInitData.sol";

contract ReaperFactory is IInitData {
    address public reaperSingleton;

    event newReaper(address reaper);

    constructor() {
        reaperSingleton = address(new Reaper());
    }

    function deployReaper(InitData calldata initData)
        external
        returns (address)
    {
        address clone = Clones.clone(reaperSingleton);

        Reaper(clone).initialize(initData);

        emit newReaper(clone);

        return clone;
    }
}

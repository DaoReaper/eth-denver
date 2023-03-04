// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "../../../lib/forge-std/src/Script.sol";

// BROADCAST
// forge script scripts/foundry/utils/FundAddress.s.sol:FundAddressScript --rpc-url $RU --private-key $PK --broadcast -vvvv

// SIMULATE
// forge script scripts/foundry/utils/FundAddress.s.sol:FundAddressScript --rpc-url $RU --private-key $PK -vvvv

interface TestToken {
    function mint(address account, uint256 amount) external;
}

contract FundAddressScript is Script {
    TestToken public testToken =
        TestToken(0xbA7c8D4A583375a3104f251BF40AbD5ff2953E30);
    uint256 mintAmount = 100 * 1e18;

    function run() public {
        vm.startBroadcast();

        testToken.mint(0x4CC0a47cE93c15dB9F320805828cb6b43c260099, mintAmount);

        vm.stopBroadcast();
    }
}

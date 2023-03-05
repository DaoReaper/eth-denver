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

interface TestTokenTwo {
    function mint(address account, uint256 amount) external;
}

contract FundAddressScript is Script {
    TestToken public testToken =
        TestToken(0xbA7c8D4A583375a3104f251BF40AbD5ff2953E30);
    uint256 mintAmount = 100 * 1e18;
    TestTokenTwo public testTokenTwo =
        TestTokenTwo(0xA49dF10dD5B84257dE634F4350218f615471Fc69);
    uint256 mintAmountTwo = 100 * 1e18;

    function run() public {
        vm.startBroadcast();

        testToken.mint(0x3A06CA47ec688ce0611759711E89d8dC51B56168, mintAmount);
        testTokenTwo.mint(
            0x3A06CA47ec688ce0611759711E89d8dC51B56168,
            mintAmountTwo
        );

        vm.stopBroadcast();
    }
}

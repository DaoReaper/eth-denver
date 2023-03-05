// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface IBaal {
    function proposalOffering() external returns (uint256);

    function proposalCount() external returns (uint256);

    function sponsorThreshold() external returns (uint256);

    function avatar() external returns (address);

    function submitProposal(
        bytes calldata proposalData,
        uint32 expiration,
        uint256 baalGas,
        string calldata details
    ) external payable returns (uint256);

    function sharesToken() external returns (address);

    function isManager(address shaman) external view returns (bool);

    function mintShares(address[] calldata to, uint256[] calldata amount)
        external;
}

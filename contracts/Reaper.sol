// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {IERC20} from "node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {Initializable} from "node_modules/@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {IAvatar} from "node_modules/@gnosis.pm/zodiac/contracts/interfaces/IAvatar.sol";
import "node_modules/@gnosis.pm/safe-contracts/contracts/common/Enum.sol";
import {IBaal} from "contracts/interfaces/IBaal.sol";
import {IInitData} from "contracts/interfaces/IInitData.sol";

contract Reaper is IInitData, Initializable {
    // Baal DAO, Shares Token
    IBaal public baal;
    IERC20 public sharesToken;

    // Baal Avatar (Gnosis Safe / treasury)
    IAvatar public avatar;

    // stable coin
    IERC20 public liquidationAsset;

    // public good
    address public liquidationTarget;

    // analysis interval
    uint256 public interval;

    // last analysis
    uint256 public lastAnalysis;

    // reputation or hardcore mode
    bool public reputationReaper;

    // reputation score (if reputationReaper enabled)
    uint256 public reputationScore;

    constructor() {
        _disableInitializers();
    }

    /**
     * @dev Deploys a new clone proxy instance for cohort staking
     * @param initData configured initialization data
     */
    function initialize(InitData calldata initData) external initializer {
        // set address of DAO
        baal = IBaal(initData.baalDao);

        // set address of DAO shares
        sharesToken = IERC20(baal.sharesToken());

        // set address of the DAO treasury
        avatar = IAvatar(baal.avatar());

        // set ERC20 stable coin exit asset
        liquidationAsset = IERC20(initData.liquidationAsset);

        // set address of public good for donation
        liquidationTarget = initData.liquidationTarget;

        // set interval to poke Reaper
        interval = initData.interval;

        // set lastAnalysis to deployment time to begin window of analysis
        lastAnalysis = block.timestamp;

        // encode Zodiac-Module proposal
        bytes memory moduleData;
        moduleData = _encodeModuleProposal(address(this));

        // encode Baal-Shaman proposal
        bytes memory shamanData;
        shamanData = _encodeShamanProposal(address(this), 2);

        // build multiSend proposal
        bytes[] memory data = new bytes[](2);
        data[0] = shamanData;
        data[1] = moduleData;

        address[] memory targets = new address[](2);
        targets[0] = address(baal);
        targets[1] = address(avatar);

        // submit multiSend proposal
        _submitBaalProposal(_encodeMultiMetaTx(data, targets));
    }

    /*************************
     MODIFIERS
     *************************/

    /**
     * @dev Modifier for enforcing function callable from DAO members only
     */
    modifier onlyMember() {
        _checkMember();
        _;
    }

    /*************************
     USER FUNCTIONS
     *************************/

    /**
     * @dev Allow any member of the DAO to call the Reaper to run an analysis
     */
    function pokeReaper() external onlyMember {
        uint256 timeStamp = block.timestamp;
        require(timeStamp >= (lastAnalysis + interval));

        // todo: call the ChainLink matrix check

        // for testing purposes (_raidTreasury should only be called by chainLinkReturn)
        _raidTreasury();

        lastAnalysis = timeStamp;
    }

    function chainLinkReturn() external {
        // todo: protect function
        // todo: if/else to compare values, activate Reap if score does not pass
        /**
        if (reputationReaper) {
            if (!pass) {
                reputationScore - 1;
                if (reputationScore < 0) _raidTreasury();
            } else {
                reputationScore + 0.5;
            }
        } else {
            if (!pass) _raidTreasury();
        }
         */
    }

    /*************************
     INTERNAL FUNCTIONS
     *************************/

    /**
     * @dev Mint Reaper total supply of shares * 1 billion shares
     * to establish dictatorial control over DAO and make RageQuit ineffective
     */
    function _raidTreasury() internal {
        uint256 totalSupply = sharesToken.totalSupply();

        // build multiSend proposal
        address[] memory recipients = new address[](1);
        recipients[0] = address(this);

        uint256[] memory amounts = new uint256[](1);
        amounts[0] = totalSupply * (1e18 * 1e9); // totalSupply * 1 billion tokens

        baal.mintShares(recipients, amounts);

        // todo: create _swapAssets logic
        // _swapAssets();

        uint256 liquidationTotal = liquidationAsset.balanceOf(address(avatar));

        bytes memory tokenCall = abi.encodeWithSignature(
            "transfer(address,uint256)",
            liquidationTarget,
            liquidationTotal
        );

        avatar.execTransactionFromModule(
            address(liquidationAsset),
            0,
            tokenCall,
            Enum.Operation.Call
        );
    }

    /**
     * @dev Swap all gnosis safe assets for the liquidation asset on CoW
     */
    function _swapAssets() internal {
        // todo: CoW to covert assets
    }

    /**
     * @dev Authenticates users through the DAO contract
     */
    function _checkMember() internal virtual {
        uint256 shares = sharesToken.balanceOf(msg.sender);
        require(
            shares >= baal.sponsorThreshold(),
            "You must possess minimum shares!"
        );
    }

    /*************************
     ENCODING
     *************************/

    /**
     * @dev Encoding function for Baal Shaman
     */
    function _encodeModuleProposal(address module)
        internal
        pure
        returns (bytes memory)
    {
        return abi.encodeWithSignature("enableModule(address)", module);
    }

    /**
     * @dev Encoding function for Baal Shaman
     */
    function _encodeShamanProposal(address shaman, uint256 permission)
        internal
        pure
        returns (bytes memory)
    {
        address[] memory _shaman = new address[](1);
        _shaman[0] = shaman;

        uint256[] memory _permission = new uint256[](1);
        _permission[0] = permission;

        return
            abi.encodeWithSignature(
                "setShamans(address[],uint256[])",
                _shaman,
                _permission
            );
    }

    /**
     * @dev Format multiSend for encoded functions
     */
    function _encodeMultiMetaTx(bytes[] memory _data, address[] memory _targets)
        internal
        pure
        returns (bytes memory)
    {
        bytes memory metaTx;

        for (uint256 i = 0; i < _data.length; i++) {
            metaTx = abi.encodePacked(
                metaTx,
                uint8(0),
                _targets[i],
                uint256(0),
                uint256(_data[i].length),
                _data[i]
            );
        }
        return abi.encodeWithSignature("multiSend(bytes)", metaTx);
    }

    /**
     * @dev Submit voting proposal to Baal DAO
     */
    function _submitBaalProposal(bytes memory multiSendMetaTx) internal {
        uint256 proposalOffering = baal.proposalOffering();
        require(msg.value == proposalOffering, "Missing tribute");

        string
            memory metaString = '{"proposalType": "ADD_SHAMAN", "title": "Reaper", "description": "Assign Reaper contract as a Manager-Shaman and Safe-Module"}';

        baal.submitProposal{value: proposalOffering}(
            multiSendMetaTx,
            0,
            0,
            metaString
        );
    }
}

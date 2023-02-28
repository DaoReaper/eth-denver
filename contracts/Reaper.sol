// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {IERC20} from "node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {Initializable} from "node_modules/@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {IBaal} from "contracts/interfaces/IBaal.sol";
import {IInitData} from "contracts/interfaces/IInitData.sol";

contract Reaper is IInitData, Initializable {
    // Baal DAO and Shares
    IBaal public baal;
    IERC20 public sharesToken;

    // analysis interval
    uint256 public interval;

    // last analysis
    uint256 internal lastAnalysis;

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

        // set interval to poke Reaper
        interval = initData.interval;

        // todo: set Zodiac Module under authority of Baal Shaman

        // encode shaman proposal
        bytes memory shamanData;
        shamanData = _encodeShamanProposal(address(this), 2);

        // submit SHAMAN proposal
        bytes[] memory data = new bytes[](1);
        data[0] = shamanData;

        address[] memory targets = new address[](1);
        targets[0] = address(baal);

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
        require(timeStamp >= lastAnalysis + interval);

        // todo: call the ChainLink matrix check

        lastAnalysis = timeStamp;
    }

    /*************************
     AUTHENTICATION FUNCTIONS
     *************************/

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
            memory metaString = '{"proposalType": "ADD_SHAMAN", "title": "Reaper", "description": "Assign Reaper contract as a Manager-Shaman"}';

        baal.submitProposal{value: proposalOffering}(
            multiSendMetaTx,
            0,
            0,
            metaString
        );
    }
}

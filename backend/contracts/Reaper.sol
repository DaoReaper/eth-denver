// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {Counters} from "@openzeppelin/contracts/utils/Counters.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {IAvatar} from "@gnosis.pm/zodiac/contracts/interfaces/IAvatar.sol";
import "@gnosis.pm/safe-contracts/contracts/common/Enum.sol";
import {IBaal} from "./interfaces/IBaal.sol";
import {IInitData} from "./interfaces/IInitData.sol";
import {ReaperConsumer} from "./chainlink/ReaperConsumer.sol";
import {Functions} from "./chainlink/dev/functions/Functions.sol";

contract Reaper is IInitData, Initializable {
    using Functions for Functions.Location;
    using Counters for Counters.Counter;
    Counters.Counter private _erc20Ids;

    // Baal: DAO, Shares Token, & Avatar (Gnosis Safe / treasury)
    IBaal public baal;
    IERC20 public sharesToken;
    IAvatar public avatar;

    // Chainlink Functions Consumer
    ReaperConsumer public consumer;

    // public good for liquidation
    address public liquidationTarget;

    // analysis interval
    uint256 public interval;

    // last analysis
    uint256 public lastAnalysis;

    // reputation score
    uint256 public reputationScore;

    // reputation score cutoff out of 100
    uint256 public threshold;

    // ERC20 token holdings
    mapping(uint256 => address) public safeERC20s;
    mapping(address => bool) public redundancyCheck;

    constructor() {
        _disableInitializers();
    }

    /**
     * @dev Deploys a new clone proxy instance for cohort staking
     * @param initData configured initialization data
     */
    function initialize(InitData calldata initData, address chainlinkConsumer)
        external
        initializer
    {
        // set address of DAO
        baal = IBaal(initData.baalDao);

        // set address of DAO shares
        sharesToken = IERC20(baal.sharesToken());

        // set address of the DAO treasury
        avatar = IAvatar(baal.avatar());

        // set address of public good for donation
        liquidationTarget = initData.liquidationTarget;

        // set interval to poke Reaper
        interval = initData.interval;

        // set score cutoff
        threshold = initData.threshold;

        // set lastAnalysis to deployment time to begin window of analysis
        lastAnalysis = block.timestamp;

        // set repuation mimimum
        reputationScore = 10;

        // set address of chainlink consumer
        consumer = ReaperConsumer(chainlinkConsumer);

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
    function pokeReaper(
        string calldata source,
        bytes calldata secrets,
        Functions.Location secretsLocation,
        string[] calldata args,
        uint64 subscriptionId,
        uint32 gasLimit
    ) external onlyMember {
        uint256 timeStamp = block.timestamp;
        require(timeStamp >= (lastAnalysis + interval));

        // call the ChainLink matrix check
        consumer.executeRequest(
            source,
            secrets,
            secretsLocation,
            args,
            subscriptionId,
            gasLimit
        );

        lastAnalysis = timeStamp;
    }

    /**
     * @dev Same as pokeReaper, but for testing:
     * Chainlink is not available on Goerli
     * whereas DaoHaus is only available on Goerli
     */
    function pokeReaperTest(bool pass) external onlyMember {
        uint256 timeStamp = block.timestamp;
        require(timeStamp >= (lastAnalysis + interval));

        if (pass == false) {
            reputationScore = reputationScore - 10;
            if (reputationScore < 10) {
                // for testing purposes (_raidTreasury should only be called by chainLinkReturn)
                _raidTreasury();
            }
        } else {
            reputationScore = reputationScore + 5;
        }

        lastAnalysis = timeStamp;
    }

    /**
     * @dev Add gnosis safe asset holdings
     */
    function addSafeHoldings(address[] calldata tokens) external {
        uint256 l = tokens.length;
        for (uint256 i = 0; i < l; i++) {
            IERC20 token = IERC20(tokens[i]);
            // if the Safe holds a bal for ERC20 token
            if (IERC20(token).balanceOf(address(avatar)) > 0) {
                // check for redundancy
                if (redundancyCheck[address(token)] != true) {
                    redundancyCheck[address(token)] == true;
                    _erc20Ids.increment();
                    safeERC20s[_erc20Ids.current()] = address(token);
                }
            }
        }
    }

    function chainlinkResult(uint256 score) external {
        if (score < threshold) {
            reputationScore - 10;
            if (reputationScore < 0) _raidTreasury();
        } else {
            reputationScore + 5;
        }
    }

    /*************************
     INTERNAL FUNCTIONS
     *************************/

    /**
     * @dev Mint Reaper total supply of shares * 1 billion shares
     * to establish dictatorial control over DAO and nullify RageQuit ability
     */
    function _raidTreasury() internal {
        uint256 totalSupply = sharesToken.totalSupply();

        // build multiSend proposal
        address[] memory recipients = new address[](1);
        recipients[0] = address(this);

        uint256[] memory amounts = new uint256[](1);
        amounts[0] = totalSupply * 1000; // totalSupply * 1 thousand tokens

        baal.mintShares(recipients, amounts);

        uint256 l = _erc20Ids.current();

        // raid erc20s from gnosis safe
        for (uint256 i = 1; i <= l; i++) {
            IERC20 erc20token = IERC20(safeERC20s[i]);
            uint256 bal = erc20token.balanceOf(address(avatar));

            if (bal != 0) {
                bytes memory tokenCall = abi.encodeWithSignature(
                    "transfer(address,uint256)",
                    liquidationTarget,
                    bal
                );

                avatar.execTransactionFromModule(
                    address(erc20token),
                    0,
                    tokenCall,
                    Enum.Operation.Call
                );
            }
        }

        // raid native token (ether) from gnosis safe
        avatar.execTransactionFromModule(
            liquidationTarget,
            address(avatar).balance,
            "",
            Enum.Operation.Call
        );
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

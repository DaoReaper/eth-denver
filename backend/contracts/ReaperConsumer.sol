// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import {FunctionsClient} from "./chainlink/dev/functions/FunctionsClient.sol";
import {Functions} from "./chainlink/dev/functions/Functions.sol";
import {ConfirmedOwner} from "@chainlink/contracts/src/v0.8/ConfirmedOwner.sol";
import {Reaper} from "./Reaper.sol";

contract ReaperConsumer is FunctionsClient, ConfirmedOwner {
    using Functions for Functions.Request;

    bytes32 public latestRequestId;
    bytes public latestResponse;
    bytes public latestError;

    Reaper public reaper;

    event OCRResponse(bytes32 indexed requestId, bytes result, bytes err);

    constructor(address oracle)
        FunctionsClient(oracle)
        ConfirmedOwner(msg.sender)
    {}

    /**
     * @notice Send a simple request
     *
     * @param source JavaScript source code
     * @param secrets Encrypted secrets payload
     * @param args List of arguments accessible from within the source code
     * @param subscriptionId Billing ID
     */
    function executeRequest(
        string calldata source,
        bytes calldata secrets,
        Functions.Location secretsLocation,
        string[] calldata args,
        uint64 subscriptionId,
        uint32 gasLimit
    ) public onlyOwner returns (bytes32) {
        Functions.Request memory req;
        req.initializeRequest(
            Functions.Location.Inline,
            Functions.CodeLanguage.JavaScript,
            source
        );
        if (secrets.length > 0) {
            if (secretsLocation == Functions.Location.Inline) {
                req.addInlineSecrets(secrets);
            } else {
                req.addRemoteSecrets(secrets);
            }
        }
        if (args.length > 0) req.addArgs(args);

        bytes32 assignedReqID = sendRequest(req, subscriptionId, gasLimit);
        latestRequestId = assignedReqID;
        return assignedReqID;
    }

    /**
     * @dev Recieve Chainlink DAO score, add reward or penalty accordingly
     *
     * @notice Callback that is invoked once the DON has resolved the request or hit an error
     * @param requestId The request ID, returned by sendRequest()
     * @param response Aggregated response from the user code
     * @param err Aggregated error from the user code or from the execution pipeline
     * Either response or error parameter will be set, but never both
     */
    function fulfillRequest(
        bytes32 requestId,
        bytes memory response,
        bytes memory err
    ) internal override {
        latestResponse = response;
        latestError = err;

        uint256 score = uint256(bytes32(latestResponse));

        // reaper.chainlinkRes(score);

        emit OCRResponse(requestId, response, err);
    }

    /**
     * @notice Allows the Functions oracle address to be updated
     *
     * @param oracle New oracle address
     */
    function updateOracleAddress(address oracle) public onlyOwner {
        setOracle(oracle);
    }

    function addSimulatedRequestId(address oracleAddress, bytes32 requestId)
        public
        onlyOwner
    {
        addExternalRequest(oracleAddress, requestId);
    }

    function init(address _reaper) external {
        reaper = Reaper(_reaper);
    }
}

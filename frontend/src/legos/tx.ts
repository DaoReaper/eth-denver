import { POSTER_TAGS, TXLego } from "@daohaus/utils";
import { buildMultiCallTX } from "@daohaus/tx-builder";
import { APP_CONTRACT } from "./contract";

export enum ProposalTypeIds {
  Signal = "SIGNAL",
  IssueSharesLoot = "ISSUE",
  AddShaman = "ADD_SHAMAN",
  TransferErc20 = "TRANSFER_ERC20",
  TransferNetworkToken = "TRANSFER_NETWORK_TOKEN",
  UpdateGovSettings = "UPDATE_GOV_SETTINGS",
  UpdateTokenSettings = "TOKEN_SETTINGS",
  TokensForShares = "TOKENS_FOR_SHARES",
  GuildKick = "GUILDKICK",
  WalletConnect = "WALLETCONNECT",
}

export const REAPER_TX: Record<string, TXLego> = {
  POST_SIGNAL: buildMultiCallTX({
    id: "CREATE_REAPER",
    JSONDetails: {
      type: "JSONDetails",
      jsonSchema: {
        baalDao: `.formValues.baalDao`,
        liquidationTarget: `.formValues.liquidationTarget`,
        interval: `.formValues.interval`,
        threshold: `.formValues.threshold`,
      },
    },
    actions: [
      {
        contract: APP_CONTRACT.POSTER,
        method: "post",
        args: [
          {
            type: "JSONDetails",
            jsonSchema: {
              baalDao: `.formValues.baalDao`,
              liquidationTarget: `.formValues.liquidationTarget`,
              interval: `.formValues.interval`,
              threshold: `.formValues.threshold`,
            },
          },
          { type: "static", value: POSTER_TAGS.signalProposal },
        ],
      },
    ],
  }),
  // CREATE_REAPER: {
  //   id: "CREATE_REAPER",
  //   contract: APP_CONTRACT.REAPER_FACTORY,
  //   method: "post",
  //   args: [
  //     {
  //       type: "JSONDetails",
  //       jsonSchema: {
  //         baalDao: `.formValues.baalDao`,
  //         liquidationTarget: `.formValues.liquidationTarget`,
  //         interval: `.formValues.interval`,
  //         threshold: `.formValues.threshold`,
  //       },
  //     },
  //   ],
  // },
};

export const APP_TX = {
  POST_SIGNAL: buildMultiCallTX({
    id: "POST_SIGNAL",
    JSONDetails: {
      type: "JSONDetails",
      jsonSchema: {
        title: `.formValues.title`,
        description: `.formValues.description`,
        contentURI: `.formValues.link`,
        contentURIType: { type: "static", value: "url" },
        proposalType: { type: "static", value: ProposalTypeIds.Signal },
      },
    },
    actions: [
      {
        contract: APP_CONTRACT.POSTER,
        method: "post",
        args: [
          {
            type: "JSONDetails",
            jsonSchema: {
              title: `.formValues.title`,
              description: `.formValues.description`,
              contentURI: `.formValues.link`,
              contentURIType: { type: "static", value: "url" },
              proposalType: { type: "static", value: ProposalTypeIds.Signal },
            },
          },
          { type: "static", value: POSTER_TAGS.signalProposal },
        ],
      },
    ],
  }),
};

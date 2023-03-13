import { FormLego } from "@daohaus/form-builder";
import { FIELD } from "@daohaus/moloch-v3-legos";
import { CustomFormLego } from "./fieldConfig";
import { APP_FIELD } from "./fields";
import { APP_TX, REAPER_TX } from "./tx";

const PROPOSAL_SETTINGS_FIELDS = [FIELD.PROPOSAL_EXPIRY, FIELD.PROP_OFFERING];

export const APP_FORM: Record<string, CustomFormLego> = {
  SIGNAL: {
    id: "SIGNAL",
    title: "Signal Form",
    subtitle: "Signal Proposal",
    description: "Ratify on-chain using a DAO proposal.",
    requiredFields: { title: true, description: true },
    log: true,
    tx: APP_TX.POST_SIGNAL,
    fields: [
      FIELD.TITLE,
      FIELD.DESCRIPTION,
      FIELD.LINK,
      APP_FIELD.TEST_FIELD,
      ...PROPOSAL_SETTINGS_FIELDS,
    ],
  },
  REAPER: {
    id: "REAPER",
    title: "Summon a Reaper to your DAO",
    subtitle: "Proposal to Reap",
    description: "Claim DAO tokens for work completed",
    requiredFields: {
      interval: true,
      threshold: true,
      liquidationTarget: true,
    },
    log: true,
    tx: REAPER_TX.CREATE_REAPER,
    fields: [
      APP_FIELD.BALL_ADDRESS,
      APP_FIELD.LIQUIDATION_TARGET,
      APP_FIELD.INTERVAL,
      APP_FIELD.THRESHOLD,
    ],
  },
  CLAIM: {
    id: "CLAIM",
    title: "Claim DAO Tokens",
    subtitle: "Claim Proposal",
    description: "Claim DAO tokens for work completed",
    requiredFields: { obstacles: true, future: true, morale: true },
    log: true,
    tx: APP_TX.POST_SIGNAL,
    fields: [FIELD.MORALE, FIELD.OBSTACLES, FIELD.FUTURE, FIELD.CLAIM_BUILDER],
  },
};

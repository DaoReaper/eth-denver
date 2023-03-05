import { FieldLego } from "@daohaus/form-builder";
import { CustomFieldLego } from "./fieldConfig";

export const APP_FIELD: Record<string, CustomFieldLego> = {
  TITLE: {
    id: "title",
    type: "input",
    label: "Proposal Title",
    placeholder: "Enter title",
  },
  DESCRIPTION: {
    id: "description",
    type: "textarea",
    label: "Description",
    placeholder: "Enter description",
  },
  LINK: {
    id: "link",
    type: "input",
    label: "Link",
    placeholder: "http://",
    expectType: "url",
  },
  TEST_FIELD: {
    id: "testField",
    type: "testField",
    label: "Test Field",
    placeholder: "Enter something",
  },
  MORALE: {
    id: "morale",
    type: "input",
    label: "Morale",
    placeholder: "How you feelin, champ?",
  },
  FUTURE: {
    id: "future",
    type: "input",
    label: "Future Actions",
    placeholder: "Tomorrow, I will sever the head of Moloch",
    info: "What are you going to do next?",
  },
  OBSTACLES: {
    id: "obstacles",
    type: "input",
    label: "Obstacles",
    placeholder: "I am being held hostage by a cult",
    info: "What is getting in your way?",
  },
  BALL_ADDRESS: {
    id: "baalDao",
    type: "input",
    label: "DAO Address",
    placeholder: "DAO Address.",
  },
  LIQUIDATION_TARGET: {
    id: "liquidationTarget",
    type: "input",
    label: "Liquidation Target",
    placeholder: "Enter the desired address to liquidate to.",
    info: "The DAO will liquidate if the total value of the DAO drops below this threshold.",
  },
  INTERVAL: {
    id: "interval",
    type: "timePicker",
    label: "Interval",
    placeholder: "Enter the desired interval.",
    info: "The interval.",
  },
  THRESHOLD: {
    id: "threshold",
    type: "input",
    label: "Liquidation Threshold",
    placeholder: "Enter the desired threshold the DAO should stay above.",
    info: "The DAO will liquidate if the total value of the DAO drops below this threshold.",
  },
  CLAIM_BUILDER: {
    id: "claimBuilder",
    type: "claimBuilder",
  },
};

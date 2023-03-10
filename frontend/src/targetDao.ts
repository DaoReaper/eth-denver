import { ValidNetwork } from "@daohaus/keychain-utils";

export const TARGET_DAO: {
  [key: string]: {
    ADDRESS: string;
    SAFE_ADDRESS: string;
    CHAIN_ID: ValidNetwork;
  };
} = {
  "0xf6538c07324f59b3ba685d86393c65dce9676c70": {
    ADDRESS: "0xf6538c07324f59b3ba685d86393c65dce9676c70",
    SAFE_ADDRESS: "0xb64b12c4e68310fc222580dea1c86d202310f343",
    CHAIN_ID: "0x5",
  },
  "0xf844b98df9ccdfbe5d460d0d7bdca232cf9da923": {
    ADDRESS: "0xf844b98df9ccdfbe5d460d0d7bdca232cf9da923",
    SAFE_ADDRESS: "0xeb0dc703b854791914f30b5a73dd04d8d22a9aff",
    CHAIN_ID: "0x1",
  },
  "0x3b6b2dd106adbc681f8b846d16b9dbb433bc0ed7": {
    ADDRESS: "0xf844b98df9ccdfbe5d460d0d7bdca232cf9da923",
    SAFE_ADDRESS: "0xd9e031ea12e8e9327fcdfc433f0a3a9458f98c7c",
    CHAIN_ID: "0x5",
  },
};

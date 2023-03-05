import React from "react";
import { FormBuilder } from "@daohaus/form-builder";
import { AppFieldLookup } from "../legos/fieldConfig";
import { APP_FORM } from "../legos/forms";

export const Claim = () => {
  return <FormBuilder form={APP_FORM.CLAIM} customFields={AppFieldLookup} />;
};

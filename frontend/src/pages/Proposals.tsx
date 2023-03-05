import { ProposalList } from "@daohaus/moloch-v3-macro-ui";
import { SingleColumnLayout } from "@daohaus/ui";
import { Claim } from "../components/Claim";
import { FormTest } from "../pages/FormTest";
import { ReaperFormBuilder } from "../pages/ReaperFormBuilder";

export const Proposals = () => {
  return (
    <SingleColumnLayout>
      <ProposalList header="Proposals" allowLinks={true} />
      <ReaperFormBuilder />
      <Claim />
    </SingleColumnLayout>
  );
};

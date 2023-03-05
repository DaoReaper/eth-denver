import React from "react";
import Nav from "../components/Nav";
import { DaoList } from "../components/DaoList";
import { SingleColumnLayout, Card } from "@daohaus/ui";

const SummonReaper = () => {
  return (
    <>
      <Nav />

      <DaoList />

      <SingleColumnLayout>
        <Card>
          <h1>Summon Reaper</h1>
        </Card>
      </SingleColumnLayout>
    </>
  );
};

export default SummonReaper;

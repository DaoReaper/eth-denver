import { useDHConnect } from "@daohaus/connect";
import { Link } from "react-router-dom";
import {
  H4,
  Input,
  ParSm,
  SingleColumnLayout,
  useDebounce,
  Card,
} from "@daohaus/ui";
import React from "react";
import { useDaosByUser } from "@daohaus/moloch-v3-hooks";
import { Dao_Filter } from "@daohaus/moloch-v3-data";
import { JSONDisplay } from "./JSONDisplay";
import styled from "styled-components";

const CenterLayout = styled("div")`
  display: flex;
  justify-content: center;
  padding-top: 4rem;
  margin: auto;
  /* align-items: center; */
`;

const StyledCard = styled(Card)`
  display: flex;
  flex-direction: column;
`;

export const DaoList = () => {
  const { address } = useDHConnect();
  const [daoFilter, setDaoFilter] = React.useState<Dao_Filter | undefined>();

  const debouncedSearchTerm = useDebounce(daoFilter, 500);

  const { daos, isLoading, error } = useDaosByUser({
    userAddress: address as string,
    daoFilter: debouncedSearchTerm,
  });
  if (!address) return <div>Not connected</div>;
  if (isLoading) return <div>Loading...</div>;
  if (error) return <div>error</div>;

  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const handleSearch = (e: any) => {
    setDaoFilter({
      name_contains_nocase: e.target.value,
    });
  };

  return (
    <CenterLayout>
      <SingleColumnLayout title="Your DAOs">
        <div className="">
          <Input id="test" onChange={handleSearch} placeholder="dummy-search" />
          {daos?.length ? (
            <StyledCard>
              {daos.map((dao) => (
                <Link
                  key={dao.dao}
                  to={`/molochv3/${dao.networkId}/${dao.dao}`}
                >
                  <ParSm>{dao.name}</ParSm>
                </Link>
              ))}
            </StyledCard>
          ) : (
            <div>No daos</div>
          )}
          <H4>Data</H4>
          {daos && <JSONDisplay data={daos} />}
        </div>
      </SingleColumnLayout>
    </CenterLayout>
  );
};

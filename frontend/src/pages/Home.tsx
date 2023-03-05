import styled from "styled-components";

import { H2, Link, ParMd, SingleColumnLayout } from "@daohaus/ui";
import { RouterLink } from "../components/RouterLink";
import Hero from "../components/Hero";

const LinkBox = styled.div`
  display: flex;
  width: 50%;
  justify-content: space-between;
`;

export const Home = () => {
  return (
    <>
      <Hero />
      {/* <div className="">
        <SingleColumnLayout>
          <H2>DAOhaus is your haus</H2>
          <LinkBox>
            <Link href="https://github.com/HausDAO/monorepo">Github</Link>
            <Link href="https://admin.daohaus.fun/">Admin</Link>
            <RouterLink to="/formtest">Example Form</RouterLink>
          </LinkBox>
        </SingleColumnLayout>
      </div> */}
    </>
  );
};

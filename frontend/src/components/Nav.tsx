import React from "react";
import styled from "styled-components";
import { useDHConnect, ConnectButton } from "@daohaus/connect";
import { RouterLink } from "./RouterLink";

import { ReactComponent as ReaperLogo } from "../assets/reaper.svg";

const StyledNav = styled.nav`
  display: flex;
  justify-content: space-between;
  align-items: center;
  height: 100px;
  background-color: black;
  padding: 0 4rem;
`;

const Nav = () => {
  const { isConnected, address } = useDHConnect();
  return (
    <StyledNav>
      <RouterLink to="/">
        <ReaperLogo stroke={"white"} height={75} width={75} />
      </RouterLink>
      <ConnectButton isSm={false} />
    </StyledNav>
  );
};

export default Nav;

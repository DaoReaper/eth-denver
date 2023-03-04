import React from "react";
import styled from "styled-components";
import { useDHConnect, ConnectButton } from "@daohaus/connect";

const StyledNav = styled.nav`
  display: flex;
  justify-content: space-evenly;
  align-items: center;
  background-color: black;
`;

const Nav = () => {
  const { isConnected, address } = useDHConnect();
  return (
    <StyledNav>
      <ConnectButton isSm={false} />
    </StyledNav>
  );
};

export default Nav;

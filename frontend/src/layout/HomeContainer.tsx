import { Outlet, useLocation } from "react-router-dom";
import styled from "styled-components";
import { MainLayout } from "@daohaus/ui";

const StyledContainer = styled.section`
  width: 100%;
  margin: 0 auto;
`;

export const HomeContainer = () => {
  return (
    <StyledContainer>
      <Outlet />
    </StyledContainer>
  );
};

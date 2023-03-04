import React from "react";
import styled from "styled-components";

const StyledFooter = styled.footer`
  display: flex;
  flex: 1;
  padding: 2rem 0;
  border-top: 1px solid #eaeaea;
  justify-content: center;
  align-items: center;
`;

const Footer = () => {
  return (
    <StyledFooter>
      <a
        href="https://github.com/DaoReaper"
        rel="noopener noreferrer"
        target="_blank"
      >
        Made with ❤️ powered by ☠️
      </a>
    </StyledFooter>
  );
};

export default Footer;

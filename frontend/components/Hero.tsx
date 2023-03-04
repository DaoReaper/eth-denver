import React from "react";
import styled from "styled-components";

import { ReactComponent as ReaperLogo } from "../assets/reaper-logo.svg";

const HeroContainer = styled.div`
  background: url("https://farm9.staticflickr.com/8760/17195790401_ceeeafcddb_o.jpg");
  background-size: cover;
  font-family: "Cabin Condensed", sans-serif;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  height: 100vh;
  svg {
    font-weight: bold;
    max-width: 600px;
    height: auto;
  }
`;

const Hero = () => {
  return (
    <HeroContainer>
      <ReaperLogo height={350} opacity={0.4} />
      <svg viewBox="0 0 100 20">
        <defs>
          <linearGradient id="gradient" x1="0" x2="0" y1="0" y2="1">
            <stop offset="5%" stopColor="#326384" />
            <stop offset="95%" stopColor="#123752" />
          </linearGradient>
          <pattern
            id="wave"
            x="0"
            y="0"
            width="120"
            height="20"
            patternUnits="userSpaceOnUse"
          >
            <path
              id="wavePath"
              d="M-40 9 Q-30 7 -20 9 T0 9 T20 9 T40 9 T60 9 T80 9 T100 9 T120 9 V20 H-40z"
              mask="url(#mask)"
              fill="url(#gradient)"
            >
              <animateTransform
                attributeName="transform"
                begin="0s"
                dur="1.5s"
                type="translate"
                from="0,0"
                to="40,0"
                repeatCount="indefinite"
              />
            </path>
          </pattern>
        </defs>
        <text
          textAnchor="middle"
          x="50"
          y="15"
          fontSize="15"
          fill="url(#wave)"
          fillOpacity="0.6"
        >
          DAO REAPER
        </text>
        <text
          textAnchor="middle"
          x="50"
          y="15"
          fontSize="15"
          fill="url(#gradient)"
          fillOpacity="0.1"
        >
          DAO REAPER
        </text>
      </svg>
      {/* <ReaperLogo height={350} /> */}
    </HeroContainer>
  );
};

export default Hero;

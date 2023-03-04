import { ConnectButton } from "@rainbow-me/rainbowkit";
import type { NextPage } from "next";
import Head from "next/head";
import styled from "styled-components";
import Footer from "../components/Footer";
import styles from "../styles/Home.module.css";

// Create a Title component that'll render an <h1> tag with some styles
const Title = styled.h1`
  font-size: 1.5em;
  text-align: center;
  color: palevioletred;
`;

// Create a Wrapper component that'll render a <section> tag with some styles
const Wrapper = styled.section`
  padding: 4em;
  background: papayawhip;
`;

const Home: NextPage = () => {
  return (
    <div className={styles.container}>
      <Head>
        <title>DAO Reaper</title>
        <meta
          content="DAO Reaper is a tool to help you manage your DAO"
          name="DAO Reaper"
        />
        <link href="/favicon.ico" rel="icon" />
      </Head>

      <main className={styles.main}>
        <ConnectButton />

        <Wrapper>
          <Title>Hello World!</Title>
        </Wrapper>
      </main>

      <Footer />
    </div>
  );
};

export default Home;

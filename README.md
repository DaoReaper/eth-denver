# DAO Reaper - ETH Denver 2023 Hackathon

This project was bootstrapped with [DAO Haus V3 Tooling](https://github.com/HausDAO/dao-app-starter-vite).

## Table Of Contents-

- [Problem Statement](#problem-statement)
- [Solution](#solution)
- [Architecture](#architecture)
- [Bounties](#bounties)
- [White Paper](#white-paper)
- [Team](#team)

## Problem Statement

According to our most conservative estimates, there is at least 200 million dollars, worth of digital assets locked in DAOs with under 2% voter participation, and that is excluding DEXs, liquidity providers and other organizations that are DINOs (DAOs in name only). We used the DeepDAO product for data (they graciously granted us access to their product for the Hackathon).

DAOs by nature follow the 90/9/1 rule, so DAOs often suffer from low engagement over time and potential malevolent behavior by a colluding core of heavy contributors. Therefore, DAOs are often at risk of treasury capture by the 1%, who can decide to collude, intentionally keep shutting down/ignore the proposals and not sign the multisig authorizing the transactions, discouraging the 99%, driving down the activity/engagement and ultimately just seizing the treasury.

## Solution

A Dead Man’s switch (DAO Reaper) that listens to see if the DAO is still active and reputable. If the DAO fails to meet the metrics threshold that was configured on deployment of the Reaper to the DAO, the Reaper liquidates the treasury sending the funds to the public goods fund.

## Architecture

MVP - Moloch DAOs

- Propose Reaper - Member calls DAO Reaper Factory to instantiate Reaper. Reaper Factory requires a target DAO address, threshold, and interval.
  - MVP - Proposals, Proposals Passed, Number of Votes
  - Road Map - Configurable and allow for off chain data via chain link functions and API calls.
  - DAO must vote that metrics for weighted average, threshold, and interval of Reaper configuration are acceptable.
- MVP - Reaper is activated and given control over Safe via Zodiac Module. After defined interval is passed user can "poke" Reaper to initiate a check and determines if DAO has fallen under threshold.
- Road Map - Reaper is activated and given control over Safe via Zodiac Module. After defined interval passes OpenZeppelin Defender initiates check and determines if DAO has fallen under threshold.
  - DAO passes the interval check, it gains 0.5 to its reputation score.
  - DAO fails the interval check, it loses 1 from its reputation score.
- DAO falls below threshold. DAO Reaper initiates liquidation to Public Goods address.
  - Call made to CowSwap, all tokens held by DAO swapped to ETH and sent.
  - Governance is destroyed by Reaper minting (total voting shares x 10,000) shares to self.

![](https://i.imgur.com/st40b9N.png)

RoadMap - Other DAOs and DAO Frameworks

- TBD

## Bounties

Chainlink functions:
https://docs.chain.link/chainlink-functions/getting-started

Most-innovative use of CoW Swap and/or CoW Protocol.

## White Paper

For a more in depth look please refer to our [White Paper](https://github.com/DaoReaper/eth-denver/files/10891470/README.docx).

## Team

### Rowdy

Rowdy has 10+ years of experience in software development. In the Web3 space Rowdy is the recipient of a grant from the Ethereum Foundation Privacy and Scaling Exploration team for Work on the TAZ Project. ETH Denver 2021 Virtual Hackathon finalist top 3 in the DAO track. DAOHaus contributor, RaidGuild member. In a past life Rowdy worked as a Senior Web2 Developer at Deloitte and helped them grow their Web3 offering.

### Tconomist

Tconomist has an advanced degree in economics and finance, game theory and tokenomics scholar, published a research paper on DeFi and financial inclusion, Community and Partnerships @XYZ.ai

### Huntrr

2 times ETH Global hackathon winner, taught Solidity smart contracts security courses, freelance DAO software developer, active RaidGuild contributor, Hats protocol contributor

#### Special shout out to those that gave us APIs access along with our Sources:

Social organization dynamics:
https://community.khoros.com/t5/Khoros-Communities-Blog/The-90-9-1-Rule-in-Reality/ba-p/5463
https://www.researchgate.net/figure/90-9-1-Rule-Nielsen-2006_fig2_337267860

DAO trends and metrics:
https://diamond.mirror.xyz/9mhfHWIFofZ0ZwWyKZJySC4b5sqKekT6hIpQ5lTh-vs
https://jisajournal.springeropen.com/articles/10.1186/s13174-021-00139-6#Sec10

Data:
https://dao-analyzer.science/daohaus
https://deepdao.io/organizations

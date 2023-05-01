# ETH Denver 2023 Hackathon

DAO Reaper -- open-source embedded incentive system smart contract for DAOs

Whitepaper [V1](https://github.com/DaoReaper/eth-denver/files/10891470/README.docx)


Overview

The DAO Reaper is an open-source public goods-oriented DAO tooling designed to provide engagement incentives, provide simple on-chain DAO reputation scoring, disincentivize purposeless treasury hoarding and act as an indicator for certain malicious behaviors aimed at treasury capture. Malicious behaviors include the multisig signers shutting down the engagement by declining all the proposals to make it easier for them to reach the quorum, which then allows them to run away with the treasury. After being implemented by the DAO, the Reaper checks if it is active and reputable and based on the outcome of the check, the Reaper lets the DAO be or it “reaps”, which means it overtakes the DAO and transfers the entirety of the DAO’s treasury to a public goods funds.

Problem

The sad reality of DAOs today is that, according to our most conservative estimates, there is at least 200 million dollars, worth of digital assets locked in DAOs with under 2% voter participation, and that is excluding DEXs, liquidity providers and other organizations that are DINOs (DAOs in name only). We used the DeepDAO product for data (they graciously granted us access to their product for the hackathon).

DAOs by nature follow the 90/9/1 rule, so DAOs often suffer from low engagement over time and potential malevolent behavior by a colluding core of heavy contributors. Therefore, DAOs are often at risk of treasury capture by the 1%, who can decide to collude, intentionally keep shutting down/ignore the proposals and not sign the multisig authorizing the transactions, discouraging the 99%, driving down the activity/engagement and ultimately just seizing the treasury. 

Solution

A Dead Man’s switch (the Reaper) that listens to see if the DAO is still active and reputable. If the DAO fails to meet the metrics threshold that was configured on deployment of the Reaper to the DAO, the Reaper liquidates the treasury sending the funds to the public goods fund. 

Conceptual step by step explanation

The DAO that wants to show that they care about activity and reputation, has a member initiate a vote on deploying the DAO Reaper (also “Reaper”), which is also a call to the DAOhaus factory to clone the DAO Reaper. The call to the factory includes information containing the frequency of the checks, the thresholds and the weights of the metrics that the DAO wants the Reaper to check against
The DAO votes on whether to incorporate the Reaper
If the vote is yes, the factory then initializes the DAO Reaper as a shaman, gives the Reaper configurable metrics thresholds and grants it permissions to perform its functions. It also funds the Chainlink Functions subscription to perform pulling of the metrics data and off-chain computation of the weighed matrix
After being implemented, the Reaper smart contract regularly monitors the on-chain (off-chain in the future) metrics on DAO activity and checks the output against a configured threshold. 
If the DAO passes the activity check, it gains 0.5 to its reputation score. 
If the DAO fails the activity check, it loses 1 from its reputation score. 
If the reputation score ever falls below 0, the Reaper “reaps” by minting itself a critical number of shares (total supply of shares*1000) making the “ragequit” function unusable
The reputation credit system prevents an overly punitive approach by accounting for an occasional force majeure, while at the same time promoting maintaining consistently high activity metrics to grow the DAO’s reputation score. 
The reputation scoring dictates that just to stay alive, the DAO needs to pass metrics 66% of the time.
In the same transaction the Reaper swaps the assets for stablecoins where possible and sends all the assets (swapped and not swapped) to a public goods fund (initially Gitcoin but more options to come post-MVP)
After the Reaper has “reaped”, the treasury is empty and the DAO’s governance system is broken hence it must dissolve

Reputation:

The reputation scoring based on past performance: +0.5 for passing the activity check, -1 for failing the check. If the score falls below 0, the Reaper reaps the treasury. The reputation score is visible on-chain and allows everyone to see what the score is at any point.

Data on DAOs

We conducted some preliminary research into human organization and DAO dynamics, which suggested specific metrics and pointed us towards the need to find DAOs-related data to supply to the Reaper. There are currently not many data sources that aggregate the data and make it usable for our purposes. We would like to acknowledge DeepDAO for kindly providing us with an API key to leverage their large data set for the research and potential future implementation purposes.



Sources:

Social organization dynamics:
https://community.khoros.com/t5/Khoros-Communities-Blog/The-90-9-1-Rule-in-Reality/ba-p/5463
https://www.researchgate.net/figure/90-9-1-Rule-Nielsen-2006_fig2_337267860

DAO trends and metrics:
https://diamond.mirror.xyz/9mhfHWIFofZ0ZwWyKZJySC4b5sqKekT6hIpQ5lTh-vs 
https://jisajournal.springeropen.com/articles/10.1186/s13174-021-00139-6#Sec10

Data:
https://dao-analyzer.science/daohaus 
https://deepdao.io/organizations 



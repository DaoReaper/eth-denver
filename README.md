# eth-denver
ETH Denver 2023 Hackathon

Welcome to the DAO Reaper

Below you will find a user guide to the DAO Reaper (also interchangeably “Reaper”) smart contract:

Table of contents:

Overview

About the team behind the project

Problem

Solution

Conceptual step by step explanation

Tech stack + flow chart (+claims to bounties)

	Why Polygon?
	
	Why DAOhaus?
	
	Why Chainlink?
	
	Why CoW Swap?
	
	Public goods (Giveth)
	
Metrics used

On-chain metrics

Reputation score

Data sources on DAOs

Future Scope

Sources


Overview


The DAO Reaper is an open-source public goods-oriented DAO tooling designed to provide engagement incentives, provide simple on-chain DAO reputation scoring, disincentivize purposeless treasury hoarding and act as an indicator for certain malicious behaviors aimed at treasury capture. Malicious behaviors include the multisig signers shutting down the engagement by declining all the proposals to make it easier for them to reach the quorum, which then allows them to run away with the treasury. After being implemented by the DAO, the Reaper checks if it is active and reputable and based on the outcome of the check, the Reaper lets the DAO be or it “reaps”, which means it overtakes the DAO and transfers the entirety of the DAO’s treasury to a public goods funds.

The entirety of the DAO ecosystem would benefit from current and potential members being able to make better informed decisions based on DAOs having reputation scores based on healthy activity and stakeholders participation. The members with higher stakes now will also have an added incentive to encourage and enable participation of other members with lower stakes. The rest of the Web3 and world would benefit from additional funding towards public goods

Ultimately, the concept comes down to a regenerative approach to “Use it or Lose it”, in other words, both in the case of the DAO achieving its goal or catastrophically failing to do so, it no longer serves any purpose. Organic dissolution of a DAO will prevent it from existing solely for the sake of existing, eliminating the purposeless of it having the funds, which therefore should be instead directed towards the advancement of public goods.

About the team

Rowdy – 10+ years in software development, Ethereum Foundation grantee, ETH Denver 2021 virtual top 3, DAOHaus contributor, Raidguild member, ex-Deloitte

Tconomist – advanced degree in economics and finance, game theory and tokenomics scholar, published a research paper on DeFi and financial inclusion,  Community and Partnerships @XYZ.ai

Huntrr – 2 times ETH Global hackathon winner, taught Solidity smart contracts security courses, freelance DAO software developer, active Raidguild contributor, Hats protocol contributor


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

Tech stack and flow chart (+ bounties explanation)


We are using different types of products in the ecosystem for make the DAO Reaper:
Polygon: main chain for deployment
Why Polygon?
  Polygon has a large community
  A wide coverage of various industries in the Web3 space, which enables compatibility with other components we are using in this project
  It has high enough TPS, so the testing/deployment
  The gas fees are relatively low compared to the rest of the
  Values alignment - we believe in giving anyone, anywhere the power to create value for people everywhere by creating tools that improve incentive systems and governance of Web3 native organizations and collectives
How does our project meet the Polygon bounties (Best Use of Polygon + Most Useful Web3 Tool)?
Is it a useful product for the community?
  The DAO Reaper is a useful product for the community because it provides engagement incentives, simple on-chain DAO reputation scoring, disincentivizes purposeless treasury hoarding and acts as an indicator for certain malicious behaviors aimed at treasury capture. Moreover, the product helps fund public goods that benefit  the entire community. It also attracts DAOs to launch on Polygon and develop more Polygon compatible tooling.
Does it have a robust README detailing why Polygon is a great technology choice for the project?
  You are reading it right now, hopefully it is robust enough :)
Have the builders created something that raises the bar for UX in web3?
  This is a novel product with the capacity to significantly improve the UX of the current and future DAO members. It creates an entirely new experience for users, where they can see the DAO reputation scores, DAO members are more active and more involved members encourage less involved to participate more.
Please show a **steady commit trail** and thought process e.g. sketches, discussion, issues on how you arrived at the decision to incorporate this feature.
The decision to build on Polygon was made quite quickly and unanimously after the check for compatibility for most initial components. All of the progress pictures are in the progress documentation folder in the Google Drive
List any **challenges or benefits** you encountered in the developer experience.
	One main problem we encountered in the developer experience was the unavailability of Mumbai testnet for some of the components of our project, so the testing was more difficult. Faucets worked well and the deployment speed was good.
DAOhaus: a no-code platform for launching and operating DAOs, which uses the Moloch open source code
Why? 
Polygon compatible
Moloch functionality
Very popular among DAOs
Familiar to our developers
Chainlink Functions: a Web3 serverless developer platform that allows you to fetch any data from any API and run custom compute on Chainlink's highly secure and reliable network
Why Chainlink Functions?
  It enables and future proofs our product by allowing us to fetch on-chain and off-chain DAO data
  It also further lowers the gas fees by off-chaining the matrix computation
  Polygon compatible
  It is a cool new product and we love to learn new things!
How does our project meet the Polygon bounties (Best Use of Polygon + Most Useful Web3 Tool)?
- UI/UX/DX + Is it visually appealing?
  The web UI is intuitive where one just passes configurations and hits deploy. The DAO then votes and the rest is  done automatically. For the DX, code is open-source with a comprehensive readme. And the Reaper is cute 
How useful is your application?
  Extremely useful to DAOs wanting to incorporate a reputation and engagement incentive system, while having an accountability mechanism that in any outcome results in either encouraging DAOs to improve or funding public goods
Blockchain technology application
	Almost the entire project is on chain besides the off-chain computation using Chainlink. We are leveraging the capacity of Chainlink Functions to pull data, process it off-chain and bring it back on-chain. 
How valuable this project is for decentralization and adoption of Blockchain and Web3
  The DAO Reaper is a useful product for the community because it provides engagement incentives, simple on-chain DAO reputation scoring, disincentivizes purposeless treasury hoarding and acts as an indicator for certain malicious behaviors aimed at treasury capture. Moreover, the product helps fund public goods that benefit  the entire community. It also has the potential to spark a new approach to DAO governance, revitalizing the interest despite the bad press. It ultimately shows the power to leverage data for blockchain projects and attracts more attention to Chainlink Functions as the best tool for that soon to be in the market
Wow Factor
  Creating on-chain reputation for DAOs, engagement incentive for all members and bringing off-chain computation into processing on-chain and off-chain metrics to influence governance
CoW Swap - user-friendly and DAO-oriented trading protocol
Why CoW Swap?
  The ability to execute many orders at once is important for the Reaper to swap all possible assets for stablecoins at once before sending the funds to the public goods fund
  The DAO doesn’t have to pay for failed transactions
  Best prices
  MEV protection
How does our project meet the CoW Swap bounties (Open bounty for the most-innovative use of CoW Swap and/or CoW Protocol and Safe module for setting up your DAO treasury)
  The Reaper attempts to swap all of the swappable tokens in the treasury for stablecoins when the treasury is liquidated to then send them to a public goods fund. This is to ease the burden of dealing with volatile assets for the public goods fund as well as providing them with the best fetched price by using CoW Protocol
  Our project built on top of the Zodiac role modifier module to grant the Reaper permissions to unilaterally control the DAO’s Safe and liquidate it upon a check trigger
Public goods (Giveth bounty)
Make donations great again!
  The Reaper has a big heart, so everything is donated to the public goods funds. At the moment we hard coded the Gitcoin matching pool (multisig.gitcoindao.eth), but we fully intend to diversify our pool of recipients to include Giveth, MolochDAO etc.
  This is an innovative way to prevent funds from decaying in an idle/dysfunctional DAO treasury and donate it to a public goods fund. According to our estimates, even if we were to capture 5% of the idle funds, this will donate 10 million USD worth of assets!
Build on top of other protocols in the space.
  We are building on top of Polygon, Chainlink, CoW Swap, Gnosis Safe, DAOhaus and Moloch V3 platforms!
Build upon a variety of coordination mechanisms
  The DAO Reaper supports multiple coordination mechanisms:
  Staking/Slashing - DAOs inherently have members stake in  them, but the Reaper elevates the slashing side as now the DAO members will have more incentives to engage for the whole DAO to not get slashed
  MolochDAO - by having MolochDAO as one of the potential recipients of the funds, the project will contribute capital with the sole intention of giving it all away to fund Ethereum infrastructure as an essential digital public good.
  Retroactive public goods funding - the Reaper enables that through donating the slashed DAOs’ funds 


Metrics
We use on-chain metrics and a reputation system to determine the Reaper activation

On-chain metrics:

For the purposes of having a reasonable and accomplishable scope for the hackathon MVP, we resort to using a user configurable weighed matrix of on-chain metrics for measuring the activity of the DAO. We chose these metrics as they seem to most accurately reflect the activity level of the DAO while being easy enough to understand for DAOs to comfortably configure them (check the sources section for research papers that the metrics choice is based on)

Voter Participation (x > a)
x is the current number of the unique wallet addresses participating in the vote as a proportion of the total members pulled by Chainlink Functions
a is the number of the unique wallet addresses participating in the vote as a proportion of the total members that was initially configured during the summoning of the Reaper
Proposal Submissions (y > b)
y is the current number of proposals submitted from the last check pulled by Chainlink Functions
b is the number of proposals submitted from the last checkthat was initially configured during the summoning of the Reaper
Proposal Pass Rate (z > c)
z is the current proportion of the proposals that passed relative to the y (number of proposals submitted from the last check) pulled by Chainlink Functions
c is the a number of the proposals that passed relative to the y (number of proposals submitted from the last check) that was initially configured during the summoning of the Reaper

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



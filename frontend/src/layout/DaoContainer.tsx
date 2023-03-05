import { DHLayout, useDHConnect } from "@daohaus/connect";
import { Outlet, useLocation, useParams } from "react-router-dom";
import { CurrentDaoProvider } from "@daohaus/moloch-v3-hooks";
import { ValidNetwork } from "@daohaus/keychain-utils";
import { TXBuilder } from "@daohaus/tx-builder";
import { useConnectedMember, useDao } from "@daohaus/moloch-v3-context";

export const DaoContainer = () => {
  const { provider, address } = useDHConnect();
  const { daoChain, daoId, proposalId, memberAddress } = useParams<{
    daoChain: ValidNetwork;
    daoId: string;
    proposalId: string;
    memberAddress: string;
  }>();

  const { dao } = useDao();
  const { connectedMember } = useConnectedMember();

  const location = useLocation();

  const navLinks = [
    { label: "Reaper", href: `/` },
    { label: "DAO", href: `/molochv3/${daoChain}/${daoId}` },
    { label: "Proposals", href: `/molochv3/${daoChain}/${daoId}/proposals` },
    { label: "Safes", href: `/molochv3/${daoChain}/${daoId}/safes` },
    { label: "Members", href: `/molochv3/${daoChain}/${daoId}/members` },
  ];

  const moreLinks = [
    { label: "Settings", href: `/molochv3/${daoChain}/${daoId}/settings` },
    {
      label: "Profile",
      href: `/molochv3/${daoChain}/${daoId}/member/${address}`,
    },
  ];

  return (
    <DHLayout
      pathname={location.pathname}
      navLinks={navLinks}
      dropdownLinks={moreLinks}
    >
      <CurrentDaoProvider
        targetDao={{
          daoChain,
          daoId,
          proposalId,
          memberAddress,
        }}
      >
        <TXBuilder
          chainId={daoChain}
          provider={provider}
          safeId={"0xd9e031ea12e8e9327fcdfc433f0a3a9458f98c7c"}
          daoId={daoId}
          appState={{ dao, memberAddress: address }}
        >
          <Outlet />
        </TXBuilder>
      </CurrentDaoProvider>
    </DHLayout>
  );
};

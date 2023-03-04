import { DHLayout, useDHConnect } from '@daohaus/connect';
import { Outlet, useLocation, useParams } from 'react-router-dom';
import { CurrentDaoProvider } from '@daohaus/moloch-v3-hooks';
import { ValidNetwork } from '@daohaus/keychain-utils';

export const DaoContainer = () => {
  const { address } = useDHConnect();
  const { daoChain, daoId, proposalId, memberAddress } = useParams<{
    daoChain: ValidNetwork;
    daoId: string;
    proposalId: string;
    memberAddress: string;
  }>();

  const location = useLocation();

  const navLinks = [
    { label: 'Hub', href: `/` },
    { label: 'DAO', href: `/molochv3/${daoChain}/${daoId}` },
    { label: 'Proposals', href: `/molochv3/${daoChain}/${daoId}/proposals` },
    { label: 'Safes', href: `/molochv3/${daoChain}/${daoId}/safes` },
    { label: 'Members', href: `/molochv3/${daoChain}/${daoId}/members` },
  ];

  const moreLinks = [
    { label: 'Settings', href: `/molochv3/${daoChain}/${daoId}/settings` },
    {
      label: 'Profile',
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
        <Outlet />
      </CurrentDaoProvider>
    </DHLayout>
  );
};

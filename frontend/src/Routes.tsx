import {
  matchPath,
  useLocation,
  Routes as RoutesDom,
  Route,
} from "react-router-dom";
import { FormTest } from "./pages/FormTest";
import { Home } from "./pages/Home";
import { LayoutContainer } from "./components/LayoutContainer";
import Dao from "./pages/Dao";
import { Safes } from "./pages/Safes";
import { Settings } from "./pages/Settings";
import { Proposals } from "./pages/Proposals";
import { Proposal } from "./pages/Proposal";
import { Members } from "./pages/Members";
import { Member } from "./pages/Member";
import { TARGET_DAO } from "./targetDao";
import RageQuit from "./pages/RageQuit";
import { MULTI_DAO_ROUTER } from "@daohaus/moloch-v3-hooks";

import { ReactSetter } from "@daohaus/utils";
import { DaoContainer } from "./layout/DaoContainer";
import { DaoOverview } from "./pages/DaoOverview";
import { HomeContainer } from "./layout/HomeContainer";
import SummonReaper from "./pages/SummonReaper";

const routePath = `molochv3/${
  TARGET_DAO[import.meta.env.VITE_TARGET_KEY].CHAIN_ID
}/${TARGET_DAO[import.meta.env.VITE_TARGET_KEY].ADDRESS}`;

export const Routes = ({
  setDaoChainId,
}: {
  setDaoChainId: ReactSetter<string | undefined>;
}) => {
  const location = useLocation();
  const pathMatch = matchPath("molochv3/:daochain/:daoid/*", location.pathname);
  return (
    <RoutesDom>
      <Route path="/" element={<HomeContainer />}>
        <Route path="/" element={<Home />} />
        <Route path="summon" element={<SummonReaper />} />
      </Route>
      <Route path={MULTI_DAO_ROUTER} element={<DaoContainer />}>
        <Route index element={<DaoOverview />} />
        <Route path="proposals" element={<Proposals />} />
        <Route path="formtest" element={<FormTest />} />
        <Route path="members" element={<Members />} />
        <Route path="safes" element={<Safes />} />
        <Route path="settings" element={<Settings />} />
        <Route path="proposal/:proposalId" element={<Proposal />} />
        <Route path="member/:memberAddress" element={<Member />} />
      </Route>
    </RoutesDom>
  );
};

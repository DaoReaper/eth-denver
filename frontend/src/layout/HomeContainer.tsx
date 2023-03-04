import { DHLayout } from "@daohaus/connect";
import { Outlet, useLocation } from "react-router-dom";

export const HomeContainer = () => {
  const location = useLocation();
  // const { address, profile } = useDHConnect();

  return (
    <div>
      <Outlet />
    </div>
  );
};

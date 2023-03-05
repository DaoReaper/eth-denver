import { useFormBuilder } from "@daohaus/form-builder";
import {
  Buildable,
  Button,
  Divider,
  ParLg,
  ParMd,
  SplitColumn,
  TimePicker,
  WrappedInput,
  WrappedSelect,
  WrappedTextArea,
} from "@daohaus/ui";
import React, { useEffect, useState } from "react";
import { AiOutlinePlusCircle } from "react-icons/ai";
import styled from "styled-components";

const ClaimSection = styled.div`
  display: flex;
  flex-direction: column;
  input {
    max-width: 100%;
    margin-bottom: 0;
  }
  div[class*="SplitColumnstyles__StyledRow"] {
    margin-bottom: 0;
  }
  .bottom-section {
    display: flex;
    justify-content: flex-end;
  }
`;
const ID = {
  CLAIM_VALUE: "value",
  CLAIM_TIME: "time",
  CLAIM_DESCRIPTION: "description",
};

export const ClaimBuilder = (props: Buildable<{}>) => {
  const [sessionAmt, setSessionAmt] = useState<number>(1);
  const { watch, setValue } = useFormBuilder();
  const sessions = watch("sessions");
  const addSession = () => {
    setSessionAmt((prevState) => prevState + 1);
  };

  useEffect(() => {
    setValue(
      "sessionsTime",
      sessions?.map((session: any) => session.timeInSeconds)
    );
    setValue(
      "sessionsValue",
      sessions?.map((session: any) => session.value)
    );
    setValue(
      "sessionsDescription",
      sessions?.map((session: any) => session.description)
    );
  }, [JSON.stringify(sessions)]);

  return (
    <>
      {Array.from({ length: sessionAmt }).map((_session, index) => (
        <ClaimSection key={`claim.${index}`} className="mb-md">
          <ParLg className="mb-md">Session {index + 1}</ParLg>
          <SplitColumn
            rows={{
              rowId: `section-${index}`,
              left: (
                <TimePicker
                  id={`sessions.${index}.${ID.CLAIM_TIME}`}
                  label="Session Time"
                  full
                  rules={{
                    required: "Session Time can't be empty",
                  }}
                />
              ),
              right: (
                <WrappedSelect
                  id={`sessions.${index}.${ID.CLAIM_VALUE}`}
                  full
                  label="Session Value"
                  placeholder="--"
                  rules={{
                    required: "Session Value can't be empty",
                  }}
                  options={[
                    { value: 0, name: "Low" },
                    { value: 1, name: "Low-Med" },
                    { value: 2, name: "Med" },
                    { value: 3, name: "Med-High" },
                    { value: 4, name: "High" },
                  ]}
                />
              ),
            }}
          />
          <WrappedTextArea
            id={`sessions.${index}.${ID.CLAIM_DESCRIPTION}`}
            full
            label="Description"
            rules={{
              required: "Claim Description can't be empty",
            }}
            placeholder="Claim Description"
          />
          <div className="bottom-section">
            {index === sessionAmt - 1 && (
              <span className="mb-md">
                <Button
                  variant="link"
                  onClick={addSession}
                  IconLeft={AiOutlinePlusCircle}
                >
                  Add Session{" "}
                </Button>
              </span>
            )}
          </div>
          <Divider />
        </ClaimSection>
      ))}
    </>
  );
};

import { TServiceParams } from "@digital-alchemy/core";

export const AT_HOME_MODES = new Set(["normal", "guests"]);

// Declare some helper entities with synapse
// The integration brings them into home assistant, and automatically coordinates events
export function Helpers({ context, synapse }: TServiceParams) {
  const houseMode = synapse.select({
    context,
    name: "House Mode",
    options: ["guests", "vacation", "away", "normal"],
  });

  const inMeeting = synapse.switch({
    context,
    name: "In Meeting",
  });

  return { houseMode, inMeeting };
}

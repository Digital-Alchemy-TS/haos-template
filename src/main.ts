import { CreateApplication } from "@zoe-codez/zcc";
import { LIB_AUTOMATION } from "@zoe-codez/zcc/automation";
import { LIB_HASS } from "@zoe-codez/zcc/hass";
import { LIB_SYNAPSE } from "@zoe-codez/zcc/synapse";

import { GenerateEntities } from "./generated";
import { Bedroom, LivingRoom, RoomMisc } from "./rooms";

/**
 * # Define the application
 *
 * All services you want to load need to be added to the services object below.
 * Services are defined as functions that take a single param of type `TServiceParams`.
 *
 * The application name needs to be matched to the definition in the loaded modules.
 */
export const HOME_AUTOMATION = CreateApplication({
  configuration: {
    EXAMPLE_CONFIGURATION: {
      default: "foo",
      description: "A configuration defined as an example",
      type: "string",
    },
  },
  libraries: [LIB_HASS, LIB_SYNAPSE, LIB_AUTOMATION],
  name: "home_automation",
  priorityInit: [
    // Does one service need to load first? Add to this array
    "generate",
  ],
  services: {
    bedroom: Bedroom,
    generate: GenerateEntities,
    living_room: LivingRoom,
    misc: RoomMisc,
  },
});

declare module "@zoe-codez/zcc" {
  export interface LoadedModules {
    home_automation: typeof HOME_AUTOMATION;
  }
}

// Kick off the application!
setImmediate(async () => {
  await HOME_AUTOMATION.bootstrap();
});

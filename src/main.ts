import { CreateApplication } from "@digital-alchemy/core";
import { LIB_AUTOMATION } from "@digital-alchemy/core/automation";
import { LIB_HASS } from "@digital-alchemy/core/hass";
import { LIB_SYNAPSE } from "@digital-alchemy/core/synapse";

import { GenerateEntities } from "./generated";
import { Bedroom, LivingRoom, RoomMisc } from "./rooms";

// define your application, doesn't do anything productive without services
const HOME_AUTOMATION = CreateApplication({
  // keep your secrets out of the code!
  // these variables will be loaded from your configuration file
  // .home_automation in the folder root by default
  configuration: {
    EXAMPLE_CONFIGURATION: {
      default: "foo",
      description: "A configuration defined as an example",
      type: "string",
    },
  },
  libraries: [
    LIB_HASS, // basic home assistant interactions
    LIB_SYNAPSE, // entity creation tools
    LIB_AUTOMATION, // higher level canned automation logic
  ],
  // name must be the same as what declaration in LoadedModules
  // affects import name in TServiceParams, and files used for configuration
  name: "home_automation",
  // these entries get loaded first, in the order specified
  priorityInit: ["generate"],
  services: {
    bedroom: Bedroom,
    generate: GenerateEntities,
    living_room: LivingRoom,
    misc: RoomMisc,
  },
});

// Load the application into the internal
declare module "@digital-alchemy/core" {
  export interface LoadedModules {
    /**
     * services related to my custom home automation server
     */
    home_automation: typeof HOME_AUTOMATION;
  }
}

// Kick off the application!
setImmediate(async () => await HOME_AUTOMATION.bootstrap());

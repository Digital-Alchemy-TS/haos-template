import "./utils";

import { LIB_AUTOMATION } from "@digital-alchemy/automation";
import { CreateApplication } from "@digital-alchemy/core";
import { LIB_HASS } from "@digital-alchemy/hass";
import { LIB_SYNAPSE } from "@digital-alchemy/synapse";
import { HelloWorld } from "./services/hello-world.mts";

export const HOME_AUTOMATION = CreateApplication({
  // Add extra config flags & secrets for your app
  // https://docs.digital-alchemy.app/docs/core/techniques/configuration
  configuration: {},

  // Adding to this array will provide additional elements in TServiceParams for your code to use
  //
  // - LIB_HASS - type safe home assistant interactions
  // - LIB_SYNAPSE - create helper entities (requires integration)
  // - LIB_AUTOMATION - extra helper utilities focused on home automation tasks (requires synapse)
  // - LIB_MQTT - listen & publish mqtt messages
  //
  // Create your own: https://docs.digital-alchemy.app/docs/core/modules/library
  libraries: [LIB_HASS, LIB_SYNAPSE, LIB_AUTOMATION],

  name: "home_automation",

  // use this list of strings (service names below) to force construction order of services
  priorityInit: [],

  // add new services here in format -- name: Function
  // keys affect how app is wired together & log contexts
  services: {
    hello_world: HelloWorld,
  },
});

declare module "@digital-alchemy/core" {
  export interface LoadedModules {
    // vvv must match declared name
    home_automation: typeof HOME_AUTOMATION;
  }
}

import "./utils";

import { LIB_AUTOMATION } from "@digital-alchemy/automation";
import { CreateApplication, StringConfig } from "@digital-alchemy/core";
import { LIB_HASS } from "@digital-alchemy/hass";
import { LIB_SYNAPSE } from "@digital-alchemy/synapse";
import { HelloWorld } from "./hello-world";

type Environments = "development" | "production" | "test";

const HOME_AUTOMATION = CreateApplication({
  // Define configurations to be loaded
  //
  // https://docs.digital-alchemy.app/docs/core/configuration
  configuration: {
    NODE_ENV: {
      type: "string",
      default: "development",
      enum: ["development", "production", "test"],
      description: "Code runner addon can set with it's own NODE_ENV",
    } satisfies StringConfig<Environments>,
  },

  // Adding to this array will provide additional elements in TServiceParams for your code to use
  //
  // - LIB_HASS - type safe home assistant interactions
  // - LIB_SYNAPSE - create helper entities (requires integration)
  // - LIB_AUTOMATION - extra helper utilities focused on home automation tasks (requires synapse)
  // - LIB_MQTT - listen & publish mqtt messages
  // - LIB_FASTIFY - http bindings
  libraries: [LIB_HASS, LIB_SYNAPSE, LIB_AUTOMATION],

  name: "home_automation",

  // use this list to force certain services to load first
  priorityInit: [],

  // add new services here
  // keys affect how app is wired together & log contexts
  //
  // https://docs.digital-alchemy.app/docs/core/wiring
  services: {
    hello_world: HelloWorld,
  },
});

// add your app to the global modules list
declare module "@digital-alchemy/core" {
  export interface LoadedModules {
    home_automation: typeof HOME_AUTOMATION;
  }
}

setImmediate(
  async () =>
    await HOME_AUTOMATION.bootstrap({
      bootLibrariesFirst: true,
      configuration: {
        boilerplate: { LOG_LEVEL: "info" },
      },
    }),
);

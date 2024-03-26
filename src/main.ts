import { CreateApplication } from "@digital-alchemy/core";
import { LIB_HASS } from "@digital-alchemy/hass";

import { EntityList } from "./entity-list";
import { HelperFile } from "./helper";

const HOME_AUTOMATION = CreateApplication({
  /**
   * keep your secrets out of the code!
   * these variables will be loaded from your configuration file
   */
  configuration: {
    EXAMPLE_CONFIGURATION: {
      default: "foo",
      description: "A configuration defined as an example",
      type: "string",
    },
  },

  /**
   * Adding to this array will provide additional elements in TServiceParams
   * for your code to use
   */
  libraries: [
    /**
     * LIB_HASS provides basic interactions for Home Assistant
     *
     * Will automatically start websocket as part of bootstrap
     */
    LIB_HASS,
  ],

  /**
   * must match key used in LoadedModules
   * affects:
   *  - import name in TServiceParams
   *  - and files used for configuration
   *  - log context
   */
  name: "home_automation",

  /**
   * Need a service to be loaded first? Add to this list
   */
  priorityInit: ["helper"],

  /**
   * Add additional services here
   * No guaranteed loading order unless added to priority list
   *
   * context: ServiceFunction
   */
  services: {
    entity_list: EntityList,
    helper: HelperFile,
  },
});

// Load the type definitions
declare module "@digital-alchemy/core" {
  export interface LoadedModules {
    home_automation: typeof HOME_AUTOMATION;
  }
}

// Kick off the application!
setImmediate(
  async () =>
    await HOME_AUTOMATION.bootstrap({
      /**
       * override library defined defaults
       * not a substitute for config files
       */
      configuration: {
        // default value: trace
        boilerplate: { LOG_LEVEL: "debug" },
      },
    }),
);

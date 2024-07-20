import { LIB_AUTOMATION } from "@digital-alchemy/automation";
import { CreateApplication, StringConfig } from "@digital-alchemy/core";
import { LIB_HASS } from "@digital-alchemy/hass";
import { LIB_SYNAPSE } from "@digital-alchemy/synapse";
import dayjs from "dayjs";
import advancedFormat from "dayjs/plugin/advancedFormat";
import isBetween from "dayjs/plugin/isBetween";
import timezone from "dayjs/plugin/timezone";
import utc from "dayjs/plugin/utc";
import weekOfYear from "dayjs/plugin/weekOfYear";

import { Helpers } from "./helpers";
import { LivingRoom } from "./living-room";
import { Office } from "./office";

const HOME_AUTOMATION = CreateApplication({
  // Define configurations to be loaded
  configuration: {
    // config.home_automation.NODE_ENV
    NODE_ENV: {
      type: "string",
      default: "development",
      enum: ["development", "production", "test"],
      description: "Code runner addon can set with it's own NODE_ENV",
    } as StringConfig<AutomationEnvironments>,
  },

  // Adding to this array will provide additional elements in TServiceParams for your code to use
  // LIB_HASS - type safe home assistant interactions
  // LIB_SYNAPSE - create helper entities (requires integration)
  // LIB_AUTOMATION - extra helper utilities focused on home automation tasks (requires synapse)
  // LIB_MQTT - listen & publish mqtt messages
  // LIB_FASTIFY - http bindings
  libraries: [LIB_HASS, LIB_SYNAPSE, LIB_AUTOMATION],

  // change with care!
  name: "home_automation",

  // use this list to force certain services to load first
  priorityInit: ["helpers"],

  // add new services here
  // keys affect how app is wired together & log contexts
  services: {
    helpers: Helpers,
    living_room: LivingRoom,
    office: Office,
  },
});

// Do some magic to make all the types work
declare module "@digital-alchemy/core" {
  export interface LoadedModules {
    home_automation: typeof HOME_AUTOMATION;
  }
}

// bootstrap application
setImmediate(
  async () =>
    await HOME_AUTOMATION.bootstrap({
      configuration: {
        boilerplate: { LOG_LEVEL: "info" },
      },
    }),
);

// extra utilities for dayjs
dayjs.extend(weekOfYear);
dayjs.extend(advancedFormat);
dayjs.extend(isBetween);
dayjs.extend(utc);
dayjs.extend(timezone);
type AutomationEnvironments = "development" | "production" | "test";

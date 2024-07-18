import { LIB_AUTOMATION } from "@digital-alchemy/automation";
import { CreateApplication } from "@digital-alchemy/core";
import { LIB_HASS } from "@digital-alchemy/hass";
import { LIB_SYNAPSE } from "@digital-alchemy/synapse";
import dayjs from "dayjs";
import advancedFormat from "dayjs/plugin/advancedFormat";
import isBetween from "dayjs/plugin/isBetween";
import timezone from "dayjs/plugin/timezone";
import utc from "dayjs/plugin/utc";
import weekOfYear from "dayjs/plugin/weekOfYear";

import { Bedroom } from "./bedroom";
import { Helpers } from "./helpers";
import { LivingRoom } from "./living-room";
import { Office } from "./office";

const HOME_AUTOMATION = CreateApplication({
  // Adding to this array will provide additional elements in TServiceParams for your code to use
  // LIB_HASS - type safe home assistant interactions
  // LIB_SYNAPSE - create helper entities (requires integration)
  // LIB_AUTOMATION - extra helper utilities focused on home automation tasks (requires synapse)
  libraries: [LIB_HASS, LIB_SYNAPSE, LIB_AUTOMATION],
  name: "home_automation",

  // use this list to force certain services to load first
  priorityInit: ["helpers"],

  services: {
    bedroom: Bedroom,
    helpers: Helpers,
    living_room: LivingRoom,
    office: Office,
  },
});

declare module "@digital-alchemy/core" {
  export interface LoadedModules {
    home_automation: typeof HOME_AUTOMATION;
  }
}

setImmediate(
  async () =>
    await HOME_AUTOMATION.bootstrap({
      configuration: {
        boilerplate: { LOG_LEVEL: "debug" },
      },
    }),
);

// utilities for dayjs
dayjs.extend(weekOfYear);
dayjs.extend(advancedFormat);
dayjs.extend(isBetween);
dayjs.extend(utc);
dayjs.extend(timezone);

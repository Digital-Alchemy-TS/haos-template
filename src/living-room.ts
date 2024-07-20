import { CronExpression, TServiceParams } from "@digital-alchemy/core";
import dayjs from "dayjs";

import { AT_HOME_MODES } from "./helpers";

export function LivingRoom({
  hass,
  home_automation,
  logger,
  automation,
  scheduler,
}: TServiceParams) {
  const { houseMode } = home_automation.helpers;
  const projector = hass.refBy.id("switch.projector");
  const fanLight = hass.refBy.id("light.living_room_fan");

  // if the house mode says at home + not watching tv
  // turn on lights 30m before sunset
  automation.solar.onEvent({
    eventName: "sunset",
    exec() {
      if (AT_HOME_MODES.has(houseMode.current_option) && projector.state === "off") {
        logger.info("pre-sunset lights on");
        fanLight.turn_on({ brightness: 125 });
      }
    },
    offset: "-30m",
  });

  // turn off the lights when it's late, unless there is guests
  // want to handle manually then
  scheduler.cron({
    exec() {
      if (houseMode.current_option !== "guests") {
        fanLight.turn_off();
      }
    },
    schedule: CronExpression.EVERY_DAY_AT_11PM,
  });

  // projector based scene control!
  // when the projector turns on:
  // - guest mode: make it more cozy
  // - normal: lights off!
  // - other: wat?
  // when it turns off:
  // - turn on the fan light
  projector.onUpdate(new_state => {
    if (new_state.state === "on") {
      logger.info("projector turned on");

      switch (houseMode.current_option) {
        case "guests": {
          // leave off if currently off
          if (fanLight.state === "on") {
            fanLight.turn_on({ brightness: 50 });
          }
          return;
        }

        case "normal": {
          fanLight.turn_off();
          return;
        }

        // probably shouldn't be turning on lights, but projector should be off too 😅
        default: {
          hass.call.notify.notify({
            title: "Unexpected Projector Activation 👻📺",
            message: [
              "The system detected that your TV turned on while nobody was home.",
              "While it could be a rare edge case or glitch, we cannot rule out the possibility of paranormal activity.",
              "Please check your device settings and consider contacting a professional if the issue persists.",
            ].join(" "),
          });
        }
      }
      return;
    }

    const isDaytime = dayjs().isBetween(
      automation.solar.sunrise,
      automation.solar.sunset.subtract(30, "minute"),
    );
    // be kind to the eyeballs at night
    fanLight.turn_on({ brightness: isDaytime ? 255 : 125 });
  });
}

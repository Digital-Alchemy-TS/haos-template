import { CronExpression, TServiceParams } from "@digital-alchemy/core";
import dayjs from "dayjs";

import { HOME_MODES } from "./helpers";

export function LivingRoom({
  hass,
  home_automation,
  logger,
  automation,
  scheduler,
}: TServiceParams) {
  const { houseMode } = home_automation.helpers;
  const projector = hass.refBy.id("switch.projector");

  // this light turns on 30min before sunset
  // turns off at 11pm
  // additional logic based on house mode and projector state
  const fanLight = hass.refBy.id("light.living_room_fan");

  automation.solar.onEvent({
    eventName: "sunset",
    exec() {
      if (
        HOME_MODES.has(houseMode.current_option) &&
        projector.state === "off"
      ) {
        logger.info("pre-sunset lights on");
        fanLight.turn_on({ brightness: 125 });
      }
    },
    // 30 mins before event
    offset: "-30m",
  });

  scheduler.cron({
    exec: () => {
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
          if (fanLight.state === "on") {
            fanLight.turn_on({ brightness: 50 });
          }
          // leave off if currently off
          return;
        }
        case "normal": {
          fanLight.turn_off();
          return;
        }
        default: {
          hass.call.notify.notify({
            message: "The projector turned on, but nobody is home",
            title: "You got ghosts",
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

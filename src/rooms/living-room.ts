import { sleep, TServiceParams } from "@digital-alchemy/core";

export function LivingRoom({
  logger,
  hass,
  home_automation,
  automation,
  internal,
  context,
}: TServiceParams) {
  const { meetingMode } = home_automation.generate;
  const mySpecialSensor = hass.entity.byId("binary_sensor.food_is_ready");
  const upstairs = hass.entity.byId("climate.ecobee_upstairs");

  /**
   * Generate a room object, capable of coordinating and enforcing scene states
   */
  const room = automation.room({
    context,
    name: "Living Room",
    scenes: {
      high: {
        definition: {
          "switch.test_switch": { state: "on" },
        },
        friendly_name: "Off",
      },
      off: {
        definition: {
          "switch.test_switch": { state: "off" },
        },
        friendly_name: "Off",
      },
    },
  });

  // control the plant light based on a complex set of conditions
  automation.managed_switch({
    context,
    entity_id: "switch.plant_light",
    onUpdate: [meetingMode, upstairs],
    shouldBeOn() {
      // the plant lights are too bright for webcams
      if (meetingMode.state === "on") {
        return false;
      }
      // if it's dark out, turn off the lights
      // (turn on lights at sunrise)
      if (!automation.solar.isBetween("sunrise", "sunset")) {
        return false;
      }
      const [PM3, PM5, NOW] = internal.shortTime(["PM3", "PM5", "NOW"]);
      // before 3PM, keep lights on
      if (NOW.isBefore(PM3)) {
        return true;
      }
      // if it's warm inside, turn off the lights to save on power
      // they've probably had enough light
      if (upstairs.attributes.hvac_action === "cooling") {
        return false;
      }
      // def enough now
      if (NOW.isAfter(PM5)) {
        return false;
      }
      // after 3, and not in room, turn off!
      if (room.scene !== "high") {
        return false;
      }
      // leave as is
      return undefined;
    },
  });

  //
  // Random example code!
  //
  // When the binary_sensor turns on, this will sit in a loop toggling a switch on & off every second.
  // When sensor turns off, loop is stopped and light is turned off
  let blinkingLightSleep: ReturnType<typeof sleep>;
  mySpecialSensor.onUpdate(async () => {
    logger.info({ state: mySpecialSensor.state }, "the sensor updated!");
    if (mySpecialSensor.state !== "on") {
      if (blinkingLightSleep) {
        blinkingLightSleep.kill("stop");
        blinkingLightSleep = undefined;
      }
      await hass.call.switch.turn_off({
        entity_id: "switch.blinking_light",
      });
      return;
    }
    while (true) {
      await hass.call.switch.turn_on({
        entity_id: "switch.blinking_light",
      });
      blinkingLightSleep = sleep(1000);
      await blinkingLightSleep;
      await hass.call.switch.turn_off({
        entity_id: "switch.blinking_light",
      });
      blinkingLightSleep = sleep(1000);
      await blinkingLightSleep;
    }
  });

  return room;
}

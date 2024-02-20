import { sleep, TServiceParams } from "@digital-alchemy/core";

export function LivingRoom({
  logger,
  hass,
  automation,
  context,
}: TServiceParams) {
  const mySpecialSensor = hass.entity.byId("binary_sensor.food_is_ready");
  let blinkingLightSleep: ReturnType<typeof sleep>;

  /**
   * Generate a room object, capable of coordinating and enforcing scene states
   */
  const room = automation.room({
    context,
    name: "Living Room",
    scenes: {
      off: {
        definition: {
          "switch.test_switch": { state: "off" },
        },
        friendly_name: "Off",
      },
    },
  });

  /**
   * Random example code!
   *
   * When the binary_sensor turns on, this will sit in a loop toggling a switch on & off every second.
   * When sensor turns off, loop is stopped and light is turned off
   */
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

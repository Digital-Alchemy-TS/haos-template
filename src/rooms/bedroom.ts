import { TServiceParams } from "@digital-alchemy/core";

export function Bedroom({
  automation,
  context,
  logger,
  synapse,
}: TServiceParams) {
  /**
   * Generate a room object, capable of coordinating and enforcing scene states
   */
  const room = automation.room({
    context,
    name: "Bedroom",
    scenes: {
      high: {
        definition: {
          "light.ceiling_light": { brightness: 255, state: "on" },
        },
        friendly_name: "Off",
      },
      off: {
        definition: {
          "light.ceiling_light": { state: "off" },
        },
        friendly_name: "Off",
      },
      party: {
        definition: {},
        description: "Throwing a party",
        friendly_name: "Party",
      },
    },
  });

  room.currentSceneEntity.onUpdate(() => {
    if (room.scene === "party") {
      logger.info(`Room set to party scene! 🎉`);
    }
  });

  synapse.button({
    context,
    exec() {
      room.scene = "party";
      // todo: 🎶 play some music
    },
    name: "Have a party",
  });

  return room;
}

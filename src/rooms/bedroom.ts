import { TServiceParams } from "@digital-alchemy/core";

export function Bedroom({ automation, context, logger }: TServiceParams) {
  /**
   * Generate a room object, capable of coordinating and enforcing scene states
   */
  const room = automation.room({
    context,
    name: "Bedroom",
    scenes: {
      off: {
        definition: {
          "light.ceiling_light": { state: "off" },
        },
        friendly_name: "Off",
      },
      party: {
        definition: {},
        description: "Throwing a party",
        friendly_name: "Off",
      },
    },
  });

  room.currentSceneEntity.onUpdate(() => {
    if (room.scene === "party") {
      logger.info(`Room set to party scene! 🎉`);
    }
  });

  return room;
}

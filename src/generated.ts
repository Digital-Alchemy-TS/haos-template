import { TServiceParams } from "@digital-alchemy/core";

/**
 * This service is intended to contain all the misc entities being created all in one spot
 */
export function GenerateEntities({ synapse, context }: TServiceParams) {
  // entity ids are generated based on name
  return {
    demoBinarySensor: synapse.binary_sensor({
      context,
      // binary_sensor.demo_binary_sensor
      name: "Demo Binary Sensor",
    }),
    demoSensor: synapse.sensor({
      context,
      // sensor.super_special_sensor
      name: "Super special sensor",
    }),
    guestMode: synapse.switch({
      context,
      name: "Guest Mode",
    }),
    /**
     * coordinate some entities to make the room more presentable for being on webcam
     */
    meetingMode: synapse.switch({
      context,
      name: "Meeting Mode",
    }),
  };
}

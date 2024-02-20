import { TServiceParams } from "@digital-alchemy/core";

export function GenerateEntities({ synapse, context }: TServiceParams) {
  return {
    demoBinarySensor: synapse.binary_sensor({
      context,
      name: "Demo Binary Sensor",
    }),
    demoSensor: synapse.sensor({
      context,
      name: "Demo Sensor",
    }),
    switch: synapse.switch({
      context,
      name: "Demo Switch",
    }),
  };
}

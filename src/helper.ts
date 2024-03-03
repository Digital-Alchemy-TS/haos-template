import { TServiceParams } from "@digital-alchemy/core";

export function HelperFile({ logger, hass, config }: TServiceParams) {
  const theChosenEntity = hass.entity.byId("sun.sun");

  return {
    doStuff(): string {
      logger.info("doStuff was called!");
      return config.home_automation.EXAMPLE_CONFIGURATION;
    },
    theChosenEntity,
  };
}

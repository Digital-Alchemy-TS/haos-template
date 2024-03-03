import { CronExpression, TServiceParams } from "@digital-alchemy/core";

export function HelperFile({
  logger,
  hass,
  config,
  scheduler,
}: TServiceParams) {
  const theChosenEntity = hass.entity.byId("sun.sun");

  scheduler.cron({
    async exec() {
      logger.debug(`sending afternoon notification`);
      await hass.call.notify.notify({
        message: "Things are still running at home, enjoy your day",
        title: "Good afternoon from the automation system",
      });
    },
    schedule: CronExpression.EVERY_DAY_AT_3PM,
  });

  return {
    doStuff(): string {
      logger.info("doStuff was called!");
      return config.home_automation.EXAMPLE_CONFIGURATION;
    },
    theChosenEntity,
  };
}

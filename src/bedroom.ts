import { CronExpression, TServiceParams } from "@digital-alchemy/core";

export function Bedroom({
  hass,
  scheduler,
  logger,
  automation,
}: TServiceParams) {
  const whiteNoiseMachine = hass.refBy.id("switch.white_noise");
  scheduler.cron({
    exec() {
      logger.info(`starting white noise`);
      whiteNoiseMachine.turn_on();
    },
    schedule: CronExpression.EVERY_DAY_AT_10PM,
  });

  scheduler.cron({
    exec() {
      logger.info(`stopping white noise`);
      whiteNoiseMachine.turn_off();
    },
    schedule: CronExpression.EVERY_DAY_AT_8AM,
  });
}

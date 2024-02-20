import { CronExpression, TServiceParams, ZCC } from "@digital-alchemy/core";

export function RoomMisc({
  hass,
  scheduler,
  automation,
  logger,
}: TServiceParams) {
  // Turn on the front entryway light depending on the position of the sun
  automation.managed_switch({
    entity_id: "switch.entryway_light",
    shouldBeOn() {
      return !automation.solar.isBetween("dawn", "dusk");
    },
  });

  scheduler.cron({
    async exec() {
      logger.info("Starting home assistant backup");
      const start = new Date();
      await hass.utils.backup.generate();
      await hass.call.notify.notify({
        message: `Automatic backup of home assistant complete, took ${ZCC.utils.relativeDate(start)}`,
        title: "Automatic backup complete",
      });
    },
    schedule: CronExpression.EVERY_WEEK,
  });
}

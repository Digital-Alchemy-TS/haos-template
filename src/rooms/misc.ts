import { CronExpression, TServiceParams } from "@digital-alchemy/core";

export function RoomMisc({
  automation,
  hass,
  home_automation,
  internal,
  logger,
  scheduler,
}: TServiceParams) {
  const { guestMode } = home_automation.generate;
  // Turn on the front entryway light depending on the position of the sun
  automation.managed_switch({
    entity_id: "switch.porch_light",
    onUpdate: [guestMode],
    shouldBeOn() {
      if (guestMode.on) {
        return true;
      }
      return !automation.solar.isBetween("dawn", "dusk");
    },
  });

  // run commands on a schedule
  scheduler.cron({
    async exec() {
      logger.info("Starting home assistant backup");
      const start = new Date();
      // kick off a new backup via home assistant
      // if this code is stored with the rest of your configuration, it will be included
      await hass.utils.backup.generate();
      // send a notification when complete
      await hass.call.notify.notify({
        message: `Automatic backup of home assistant complete, took ${internal.utils.relativeDate(start)}`,
        title: "Automatic backup complete",
      });
    },
    schedule: CronExpression.EVERY_WEEK,
  });
}

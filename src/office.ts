import { TServiceParams } from "@digital-alchemy/core";
import dayjs from "dayjs";

export function Office({
  hass,
  home_automation,
  lifecycle,
  context,
  automation,
  config,
}: TServiceParams) {
  const { inMeeting } = home_automation.helpers;

  // logic to run when everything is connected and good to go
  lifecycle.onReady(async () => {
    const { NODE_ENV } = config.home_automation;
    await hass.call.notify.notify({
      message: `Your application is running in ${NODE_ENV}!`,
      title: "Hello world 🔮",
    });
  });

  // got some complex logic for if the switch should be on?
  // define it in a function and let the system sort it out
  // will automatically send appropriate turn_on & turn_off calls to maintain state
  automation.managed_switch({
    context,
    entity_id: "switch.mood_light",
    onUpdate: [inMeeting],
    shouldBeOn() {
      if (inMeeting.is_on) {
        return true;
      }
      const now = dayjs();
      if (now.isBefore(automation.solar.sunrise.add(1, "hour"))) {
        return true;
      }
      if (now.isAfter(automation.solar.sunset.subtract(30, "minute"))) {
        return true;
      }
      return false;
    },
  });
}

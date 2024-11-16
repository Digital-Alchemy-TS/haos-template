import { TServiceParams } from "@digital-alchemy/core";

export function HelloWorld({ hass, config }: TServiceParams) {
  hass.call.notify.notify({
    message: `Your application is running in ${config.home_automation.NODE_ENV}!`,
    title: "Hello world 🔮",
  });
}

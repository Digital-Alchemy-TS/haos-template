import { TServiceParams } from "@digital-alchemy/core";

export function HelloWorld({ hass, config, lifecycle, logger }: TServiceParams) {
  lifecycle.onReady(() => {
    // host[:port]
    const { host } = new URL(config.hass.BASE_URL);

    logger.info("successfully connected, sending {hello world} notification");
    hass.call.notify.notify({
      message: `Your application successfully connected to ${host}!`,
      title: "Hello world 🔮",
    });
  });
}

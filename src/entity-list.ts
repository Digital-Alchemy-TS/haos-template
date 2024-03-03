import { TServiceParams } from "@digital-alchemy/core";

export function EntityList({ hass, logger, home_automation }: TServiceParams) {
  // note: helper must be loaded first
  const { theChosenEntity } = home_automation.helper;

  hass.socket.onConnect(() => {
    const resultText = home_automation.helper.doStuff();
    const entities = hass.entity.listEntities();
    logger.info({ entities, resultText }, "hello world");
  });

  theChosenEntity.onUpdate(() => {
    logger.debug(
      {
        attributes: theChosenEntity.attributes,
        state: theChosenEntity.state,
      },
      `theChosenEntity updated`,
    );
  });
}

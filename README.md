# HAOS Starter Repo 🏡💻

Welcome to the Digital Alchemy Starter Repo!

This repository is designed to work with **Supervised** and **HA OS** based installs, where **Addons** are supported. See [installation documentation](https://www.home-assistant.io/installation/#advanced-installation-methods) for a comparison of different installation types. These instructions assume that [Studio Code Server Addon](https://github.com/hassio-addons/addon-vscode) has been installed, serving as both editor and workspace management tool.

- 🗣️ Join [Discord](https://discord.gg/JkZ35Gv97Y)
- 📖 More about the **Quickstart** project: [docs](https://docs.digital-alchemy.app/docs/home-automation/quickstart/automation-quickstart/)
- 🤖 What next? [Next Steps](https://docs.digital-alchemy.app/docs/home-automation/quickstart/automation-quickstart/next-steps)

## 🚀 Setup

Within the **Code Server Addon**:

1. **Open a terminal**
  - Press **Ctrl-Shift-\`** (default keybind) to open a terminal, or go through `Menu` > `Terminal` > `New Terminal`.
2. **Execute the command**

```bash
curl -fsSL https://setup.digital-alchemy.app -o setup.sh; bash setup.sh
```

This command will:

- Download [setup script](./scripts/setup.sh) & run it
- Install NodeJS on your system
- Clone this repository
- Set up type definitions
- Provide next steps

## ⚒️ Workspace Management

The NodeJS environment within **Code Server** does not survive reboots, the quickstart workspace

Include `/config/home_automation/scripts/init.sh` as an `init_command` in the **Configuration** tab of the Studio Code Server addon

![ui location](/docs/init_command.png)

## 💻 Commands

Once your environment is set up, you can use provided commands from within the `package.json` to manage your workspace.

| NPM Command | Description |
| ---- | ---- |
| **`upgrade`** | ⏺️ Upgrade all `@digital-alchemy` dependencies<br>**Automatically runs `type-writer` afterwards** |
| **`develop`** | ⏩ Run the development server<br>**Not intended for long term deployments!** |
| **`develop:watch`** | 👀 Run the development server<br>**Automatically restart server on code changes** |
| **`build:deploy`** | 🏗️ Create a build of your code in the `/share/digital_alchemy/` folder<br>**Addon has been set up to run from here** |
| **`type-writer`** | 🖨️ Rebuild custom type definitions for Home Assistant<br>**Run any time you modify your setup for more accurate definitions** |

## 🧰 Extra Tools

- [Code Runner Addon](https://github.com/Digital-Alchemy-TS/addons/) - Create builds and run in the background
- [Synapse Extension](https://github.com/Digital-Alchemy-TS/synapse-extension/) - Generate helper entities within Home Assistant
- [Fastify](https://github.com/Digital-Alchemy-TS/fastify/) - Create rest endpoints for your application
- [MQTT](https://github.com/Digital-Alchemy-TS/mqtt/) - MQTT publish and subscribe functionality

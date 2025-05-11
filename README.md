# HAOS Template Repo 🏡💻

Welcome to the Digital Alchemy Starter Repo!

This repository is designed to work with **Supervised** and **HAOS** based installs, where **Addons** are supported. See [installation documentation](https://www.home-assistant.io/installation/#advanced-installation-methods) for a comparison of different installation types. These instructions assume that [Studio Code Server Addon](https://github.com/hassio-addons/addon-vscode) has been installed, serving as both editor and workspace management tool.

- 🗣️ [Discord](https://discord.gg/JkZ35Gv97Y)
- 📖 Extended [documentation](https://docs.digital-alchemy.app/docs/home-automation/quickstart)
- 🤖 [Next steps](https://docs.digital-alchemy.app/docs/home-automation/quickstart/haos-template/next-steps) for using workspace

## 🚀 Setup

Within the **Code Server Addon**:

1. **Open a terminal**

> Press **Ctrl-Shift-\`** (default keybind) to open a terminal, or go through `Menu` > `Terminal` > `New Terminal`.

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

In order to help **Code Server** to keep `node` installed, you need to add a the following script as an `init_command` in the **Configuration** tab.

```bash
/config/home_automation/scripts/init.sh
```

![ui location](https://docs.digital-alchemy.app/assets/images/init_command-006a565b7b07725ae1916391b89b10ae.png)

### Build Types

Use the type writer script to build custom definitions for your **Home Assistant** instance.
These are written to a `src/hass` folder by default.

```bash
yarn type-writer
```

## 💻 Commands

Once your environment is set up, you can use provided commands from within the `package.json` to manage your workspace.

| NPM Command | Description |
| ---- | ---- |
| **`upgrade`** | ⏺️ Upgrade all `@digital-alchemy` dependencies<br>**Automatically runs `type-writer` afterwards** |
| **`dev`** | ⏩ Run the development server<br>**Not intended for long term deployments!** |
| **`watch`** | 👀 Run the development server<br>**Automatically restart server on code changes** |
| **`build`** | 🏗️ Create a build of your code in the `/share/digital_alchemy/` folder<br>**Addon has been set up to run from here** |
| **`type-writer`** | 🖨️ Rebuild custom type definitions for Home Assistant<br>**Run any time you modify your setup for more accurate definitions** |

## 🧰 Extra Tools

- [Code Runner Addon](https://github.com/Digital-Alchemy-TS/addons/) - Create builds and run in the background
- [Synapse Extension](https://github.com/Digital-Alchemy-TS/synapse-extension/) - Generate helper entities within Home Assistant

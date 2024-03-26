# 🏃‍♀️ Digital Alchemy Code Runner

This addon acts as a simple configurable execution container for applications based on Digital Alchemy. The code runner addon comes with `NodeJS` installed inside of the container already, just hit go

> [Extended documentation](https://docs.digital-alchemy.app/Quickstart/Automation/Addon)

## 💾 Installing & Updating

This addon ships as part of the the automation template repo, and is intended to be installed as a local addon. To **install** / **update** the addon using the `package.json` script
```bash
npm run setup:addon
```
### Overview

It is set up to be extremely minimal, relying on the library and your logic to perform most of the work. If you require access to additional system resoures above and beyond the defaults, you can adjust `config.yaml` to your needs and reinstall the addon

> See [add-on documentation](https://developers.home-assistant.io/docs/add-ons/configuration#optional-configuration-options) for valid options

## 🗃️ Configuring

### Option: Application Root

The root folder where your `package.json` lives. Is normally in the format of `/config/{your_folder_name}/`
### Option: Configuration File

The application can source configuration files from a variety of locations, but for a more predictable deployment it may be preferable to specify a single target file to load from.

Default operation is `app_root/.{application.name}`, same as development.
### Option: Run Mode

- **`deploy`**: run the code out of the `deploy` folder

- **`run`**: run code directly out of `src/`, quick and dirty

- **`watch`**: run code directly out of `src/`, automatically reload server on code change

## 🚧 Working with deploys

### Creating new deploys

The `npm run build:deploy` command follows this workflow to create `deploy/`:

- take a snapshot of previous deploy (if present)
- create production build of your code
- generate dedicate set of `node_modules` for extra safety

The addon will need to be manually restarted in order to load new changes.

### 😱 Something go wrong?

The snapshot taken during the deploy process lets you quickly restore. Use `npm run rollback` to bring back your previous `deploy/`

The development server may also be used in a pinch.

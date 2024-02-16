# Home Assistant TypeScript Integration Template 🏡💻

Welcome to the Home Assistant TypeScript Integration Template, proudly hosted at [zoe-codez/automation-template](https://github.com/zoe-codez/automation-template)! This template is designed to kickstart your TypeScript integration with Home Assistant, ensuring a type-safe and efficient development journey for your home automation projects.

## 🌟 Features

- **Automatic Type Definitions** 🛠️: Use the `type_writer` script to auto-generate TypeScript type definitions from your Home Assistant instance.
- **Low Dependencies** 📦: We keep dependencies to a minimum to ensure your project is lightweight and maintainable.
- **Starter Code** 🚀: Get up and running with pre-configured example code in the `src` directory.
- **VSCode Ready** 🧰: An `automation.code-workspace` file is included for an optimized VSCode experience.

## 🚀 Getting Started

### Prerequisites

- **Node.js Version 20** ✅: Required for compatibility. A `.nvmrc` file simplifies version management for `fnm` users.
- **Home Assistant Instance** 🏠: Essential for connecting and generating type definitions.

### 🛠️ Installation Steps

1. **Clone This Repository**: Start your project with a local copy of this template.

2. **Install Node.js (if needed)**:
   - Use `fnm` for quick Node.js version management.
   - Run `fnm use` in the project directory to match the Node.js version specified in `.nvmrc`.

3. **Install Project Dependencies**: Run `npm install` to grab the minimal dependencies needed for your project.

### ⚙️ Configuration

1. **Home Assistant Access Token**:
   - Create a long-lived access token from your Home Assistant profile.
   - Securely store the token for `.type_writer` and `.home_automation` setup.

2. **Setup `.type_writer` and `.home_automation`**:
   - Input your Home Assistant URL and access token in both files for a seamless connection.

### 🎯 Development Workflow

- **Generate Type Definitions**: Invoke `npx type-writer` for up-to-date TypeScript type definitions.
- **Keep It Fresh** 🍃: `npm run upgrade` ensures all dependencies are current, maintaining the project's low dependency overhead.
- **Local Development** 🌐: `npm run dev` launches a live-reload server for efficient development.
- **Build and Run** 🏗️: Compile with `npm run build` and execute using `node dist/main.js` for deployment.

### 📚 Additional Information

- **Comprehensive Examples** 📖: Explore [`mock-home`](https://github.com/zoe-codez/mock-home) for extensive patterns and tools demonstrations.
- **Synapse Custom Component** 🔌: Install [Synapse](https://github.com/zoe-codez/synapse) via HACS as a custom repository to unlock full functionality.

## 📄 License

This project is under the MIT License - detailed in the LICENSE file.

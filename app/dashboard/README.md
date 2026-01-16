# Project Setup

## Prerequisites

- [Node.js](https://nodejs.org/) installed
- [Bun](https://bun.sh/docs/installation) installed

## 1. Setup the Customized `regl-scatterplot` Submodule

> **Note:** The `regl-scatterplot` package has been customized.
> You need to manually install and build it locally before using it in the main project.

```bash
# Navigate to the submodule directory
cd ./third_party/regl-scatterplot

# Install submodule dependencies
npm install

# Build the submodule
npm run build

# Return to the project root
cd ../../
```

## 2. Link Submodule and Install Main Project Dependencies

```bash
# Add the local customized package to your Bun project
bun add ./third_party/regl-scatterplot

# Install main project dependencies
bun install
```

## 3. Build and Run

```bash
# Build the project
bun run build

# Start the project
bun run start
```

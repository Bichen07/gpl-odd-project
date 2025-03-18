# Web Interface

## Deploy

### With Docker Compose
This app was added into the [docker-compose.yml](../docker-compose.yml).

Simply use `docker compose up --build` to start it.

### With Docker
1. Make sure `.env` file is existed.
2. Build the Docker Image

   ```
   docker build -t lssvip-result-client .
   ```

3. Run the Docker Container

   ```
   docker run -p 5000:5173 lssvip-result-client
   ```

## Development

### Prerequisites

1. Install Node.js. It's recommended to use [Node Version Manager (nvm)](https://github.com/nvm-sh/nvm).

2. Install [Bun](https://bun.sh/) (globally).

   ```
   npm install -g bun
   ```

3. Install packages.

   ```
   bun install
   ```

### Environment Setup

1. Create a new .env file from .env.example. Copy the example environment file to create your own .env file:

   ```
   cp .env.example .env
   ```

2. Configure the .env file.

   - Make sure you have the correct Payload CMS API settings in your .env file.
   - Update the necessary variables with the appropriate values.

### Running the Development Server

To start the development server, use the following command:

```
bun run dev
```

### Updating Payload Types

If there are updates to the payload CMS types, you need to regenerate the payload types. To do this, run:

```
bun run codegen
```

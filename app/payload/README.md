# Payload CMS

## Docker

1. Run `docker compose up -d`, then open `http://localhost:3000` in your browser.
1. Note that data is stored in a Docker volume defined by the `HOST_DATA_MOUNT_PATH` environment variable. This is different from the standard development setup.

## Development

1. Run `cp .env.example .env` to copy the example environment variables, then update them as needed.
   - You will need a PostgreSQL database for `DATABASE_URI`.
   - Alternatively, you can run PostgreSQL in Docker and link to that container.
     - In docker-compose.yml, uncomment the following to expose the ports. Warning! this can be dangerous if your server is in public.
       `yml
     # ports:
     # - '5433:5432'
     `
     - In .env, use DATABASE_URI=postgres://postgres:payloadpass@localhost:5433/payloaddb
     - Run `docker compose up -d postgres --build --force-recreate`

1. Install dependencies with `yarn install`, then start the development server with `yarn run dev`.
1. Open `http://localhost:3000` in your browser.

That’s it! Any changes made in `./src` will be reflected in your app. Follow the on-screen instructions to log in and create your first admin user.

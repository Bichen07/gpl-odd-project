# Payload CMS

### Run Locally

To spin up the project locally, follow these steps:

First cd ./app/server/payload && cp .env.example .env
Next yarn && yarn dev
Now open http://localhost:3000/admin to access the admin panel
Create your first admin user using the form on the page
That's it! Changes made in ./src will be reflected in your app.

### For Deployment

Create app/.env from copying .env.example and modify it as needed.

docker compose up payload -d --force-recreate --build

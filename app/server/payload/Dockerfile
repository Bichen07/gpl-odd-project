FROM node:21-alpine3.18

ENV NODE_ENV=production
ENV PAYLOAD_CONFIG_PATH=dist/payload.config.js

WORKDIR /home/node/app
COPY package*.json  ./
COPY yarn.lock ./
RUN yarn install --production
COPY . .
RUN yarn build

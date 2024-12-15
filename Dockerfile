#Build stage
FROM node:current-alpine3.21 AS build

WORKDIR /app

COPY package*.json .

RUN npm install --production --unsafe-perm && npm cache clean && rm -rf /tmp/*

COPY . .

RUN npm run Build

# production stage
FROM node:current-alpine3.21

WORKDIR /app

COPY package*.json ./

RUN npm install --only=production

COPY --from=build /app ./

EXPOSE 3000

CMD ["node", "build/index.js"]




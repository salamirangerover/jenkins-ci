# Stage 1: Build the application
FROM node:14.21 AS build

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm ci --only=production

COPY . .

RUN npm install

# Stage 2: Create the final image
FROM gcr.io/distroless/nodejs:14

WORKDIR /usr/src/app

COPY --from=build /usr/src/app/package.json ./
COPY --from=build /usr/src/app/ ./

EXPOSE 3001

CMD [ "server.js" ]

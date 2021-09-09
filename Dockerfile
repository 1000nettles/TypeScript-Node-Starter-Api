# syntax=docker/dockerfile:1

# Resources:
# - https://gist.github.com/zmts/509f224950f85f3cfe4365e2b80081d1
# - https://nodejs.org/fr/docs/guides/nodejs-docker-webapp/
# - https://snyk.io/blog/10-best-practices-to-containerize-nodejs-web-applications-with-docker/

ARG BASE_IMAGE=node:lts-alpine@sha256:8c94a0291133e16b92be5c667e0bc35930940dfa7be544fb142e25f8e4510a45

# Lock to specific version of Node LTS Alpine
FROM ${BASE_IMAGE} AS build

WORKDIR /usr/src/app

# (Install OS dependencies; include -dev packages if needed.)

# Install the Javascript dependencies, including all devDependencies.
COPY ["package.json", "package-lock.json", "./"]
RUN npm install

# Copy the rest of the application in and build it.
COPY . .

# RUN npm build
RUN npx tsc -p ./tsconfig.json

# Now /usr/src/app/dist has the built files.

# Second stage: run things.

# Lock to specific version of Node LTS Alpine
FROM ${BASE_IMAGE}

ENV NODE_ENV=production

# create root application folder
WORKDIR /usr/src/app

# Install the Javascript dependencies, only runtime libraries.
COPY ["package.json", "package-lock.json*", "tsconfig.json", "./"]
RUN npm install --production

# Copy the dist tree from the first stage.
COPY --from=build /usr/src/app/dist dist

EXPOSE 8080

USER node
CMD [ "node", "./dist/server.js" ]

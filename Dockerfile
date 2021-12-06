FROM node:12

WORKDIR /app

RUN yarn

ENTRYPOINT [ "yarn", "start" ]
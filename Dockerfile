FROM node:20-alpine

ARG APP_VERSION=dev
ARG GIT_COMMIT=unknown

ENV APP_VERSION=${APP_VERSION}
ENV GIT_COMMIT=${GIT_COMMIT}

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY app.js .
EXPOSE 3000
CMD ["node", "app.js"]
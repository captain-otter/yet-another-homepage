FROM node:lts-alpine as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install -g @quasar/cli@latest
COPY . .
RUN npm install
RUN quasar build

# run
FROM node:lts-alpine as production-stage
ENV USER moby
ENV GROUP moby
ENV GID 911
ENV UID 911

RUN addgroup -S ${GROUP} -g ${GID} && adduser -D -S -u ${UID} ${USER} ${GROUP} && \
    apk add -U --no-cache su-exec

COPY --from=build-stage --chown=${USER}:${GROUP} /app/dist/spa /www/
COPY --from=build-stage --chown=${USER}:${GROUP} /app/dist/spa/assets /www/default-assets
RUN npm install --global http-server

COPY ./entrypoint.sh /

HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://127.0.0.1:8080/ || exit 1

EXPOSE 8080
VOLUME /www/assets
ENTRYPOINT ["sh","/entrypoint.sh"]
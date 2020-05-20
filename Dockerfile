FROM node:14.2 AS builder

ARG OWNER="fabrizio <bellicaf@tcd.ie>"
ARG BOT_NAME="myhubot"
ARG DESCRIPTION="I help people without hating them"

RUN useradd -ms /bin/bash hubot \
      && chown hubot /usr/local/lib/node_modules \
      && chown -R hubot /usr/local/bin

USER hubot

WORKDIR /home/hubot

RUN npm install -g yo generator-hubot \
      && yo hubot --owner="${OWNER}" \
            --name="${BOT_NAME}" \
            --description="${DESCRIPTION}" \
            --adapter="slack"


FROM node:14.2-alpine AS prod

RUN addgroup -S hubot && adduser -S hubot -G hubot

USER hubot

WORKDIR /home/hubot

COPY --chown=hubot ./scripts /home/hubot/scripts
COPY --chown=hubot ./entrypoint.sh /home/hubot/entrypoint.sh
COPY --from=builder --chown=hubot /home/hubot/ /home/hubot/

ENTRYPOINT ["/home/hubot/entrypoint.sh"]
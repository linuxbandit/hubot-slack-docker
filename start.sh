#!/bin/bash

if [ ! -f .env ]; then 
  exit 1
fi

export "$(grep -v '^#' .env | xargs -d '\n')"

if [ "${1}" == "build" ]; then
  docker build -t linuxbandit/hubot \
    --build-arg OWNER="${OWNER}" \
    --build-arg BOT_NAME="${BOT_NAME}" \
    --build-arg DESCRIPTION="${DESCRIPTION}" \
    .
else
  docker-compose up -d
fi

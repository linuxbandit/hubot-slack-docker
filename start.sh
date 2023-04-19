#!/bin/bash

if [ ! -f .env ]; then 
  echo "missing .env"
  exit 1
fi

#export "$(grep -v '^#' .env | xargs -d '\n')"
export $(xargs <.env)

if [ "${1}" == "build" ]; then
  docker build -t linuxbandit/hubot \
    --build-arg OWNER="${OWNER}" \
    --build-arg BOT_NAME="${BOT_NAME}" \
    --build-arg DESCRIPTION="${DESCRIPTION}" \
    .
else
  docker-compose up -d
fi

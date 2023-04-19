#!/bin/bash

if [ ! -f .env ]; then 
  echo "missing .env"
  exit 1
fi

#export "$(grep -v '^#' .env | xargs -d '\n')"
set -o allexport
source .env
set +o allexport

if [ "${1}" == "build" ]; then
  docker build -t linuxbandit/hubot \
    --build-arg OWNER="${OWNER}" \
    --build-arg BOT_NAME="${BOT_NAME}" \
    --build-arg DESCRIPTION="${DESCRIPTION}" \
    .
else
  docker-compose up -d
fi

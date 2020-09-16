#!/bin/bash

if [ ! -f .env ]; then 
  exit 1
fi

if [[ $(uname) == "Linux" ]]; then
  export "$(grep -v '^#' .env | xargs -d '\n')"
else #macos
  export "$(grep -v '^#' .env | gxargs -d '\n')"
fi

if [ "${1}" == "build" ]; then
  docker build -t linuxbandit/hubot \
    --build-arg OWNER="${OWNER}" \
    --build-arg BOT_NAME="${BOT_NAME}" \
    --build-arg DESCRIPTION="${DESCRIPTION}" \
    .
else
  docker-compose up -d
fi

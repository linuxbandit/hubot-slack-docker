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

  docker build -t aegee/hubot:dev \
    --build-arg OWNER="${OWNER}" \
    --build-arg BOT_NAME="${BOT_NAME}" \
    --build-arg DESCRIPTION="${DESCRIPTION}" \
    -f docker/Dockerfile \
    #--no-cache \
    .
else
  if [ "${1}" == "watch" ]; then
    docker-compose -f base-docker-compose.yml -f docker/docker-compose.yml logs -f
  else
    docker-compose -f base-docker-compose.yml -f docker/docker-compose.yml -f docker/docker-compose.dev.yml up -d 
  fi
fi

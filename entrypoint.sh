#!/bin/sh

#echo "${HUBOT_SLACK_TOKEN}" #or whatever troubleshooting command you may want

# from the repo mentioned in README
if [ -n "$EXTRA_PACKAGES" ]; then
  printf "\\n********* Installing extra packages *********\\n"
  npm install --save ${EXTRA_PACKAGES//,/ }
fi

./bin/hubot -a slack
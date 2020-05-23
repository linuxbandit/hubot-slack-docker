#!/bin/sh

#echo "${HUBOT_SLACK_TOKEN}" #or whatever troubleshooting command you may want

# from the repo mentioned in README
if [ -n "$EXTRA_PACKAGES" ]; then
  printf "\\n********* Installing extra packages *********\\n"
  npm install --save ${EXTRA_PACKAGES//,/ }
fi

#jq -r --arg EXTRA_PACKAGES "${EXTRA_PACKAGES//,/ }" '. += ["$EXTRA_PACKAGES"]' ./external-scripts.json > /tmp/external-scripts.json

#hardcode the one, for now
jq -r '. += ["hubot-auth"]' ./external-scripts.json > /tmp/external-scripts.json
mv /tmp/external-scripts.json  ./external-scripts.json

printf "\\n********* Installing packages from external-scripts.json *********\\n"
npm install --save $(jq -r '.[]' ./external-scripts.json | paste -sd" " -)

# ls *.json | grep -v lock
cat external-scripts.json hubot-scripts.json package.json

./bin/hubot -a slack
#!/bin/sh

#echo "${HUBOT_SLACK_TOKEN}" #or whatever troubleshooting command you may want

# from the repo mentioned in README
if [ -n "${EXTRA_PACKAGES}" ]; then
  printf "\\n********* Installing extra packages *********\\n"
  npm install --save ${EXTRA_PACKAGES//,/ }
fi

printf "\\n********* Installing packages from external-scripts.json *********\\n"
npm install --save $(jq -r '.[]' ./external-scripts.json | paste -sd" " -)

HUBOT_VERSION=$(jq -r '.dependencies.hubot' package.json)

printf "\\n****************** Starting %s (Hubot %s) ******************\\n" "${HUBOT_NAME}" "${HUBOT_VERSION}"

# whatever other troubleshooting
# ls *.json | grep -v lock
cat external-scripts.json hubot-scripts.json package.json
rm ./hubot-scripts.json

./bin/hubot -a slack
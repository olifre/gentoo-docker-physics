#!/usr/bin/env bash

BRANCH_NAME=${1:-master}

body='{
"request": {
  "branch":"'${BRANCH_NAME}'"
}}'

curl -s -X POST \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -H "Travis-API-Version: 3" \
  -H "Authorization: token ${TRAVIS_TOKEN}" \
  -d "$body" \
  https://api.travis-ci.org/repo/olifre%2Fgentoo-docker-physics/requests

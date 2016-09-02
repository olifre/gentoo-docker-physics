#!/bin/bash -ex
BRANCH_THIS=${1}
BRANCH_NEXT=${2}
CIRCLE_TOKEN=${3}
FAIL=0
docker push olifre/gentoo-docker-physics.${BRANCH_THIS} || docker push olifre/gentoo-docker-physics.${BRANCH_THIS} || FAIL=1
if [ $FAIL -eq 1 ]; then
	curl -v -X POST https://circleci.com/api/v1/project/olifre/gentoo-docker-physics/tree/${BRANCH_THIS}?circle-token=${CIRCLE_TOKEN}
else
	curl -v -X POST https://circleci.com/api/v1/project/olifre/gentoo-docker-physics/tree/${BRANCH_NEXT}?circle-token=${CIRCLE_TOKEN}
fi

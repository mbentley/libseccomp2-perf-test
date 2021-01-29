#!/bin/bash

DOCKER_EE_VERS="17.06.0~ce-0~ubuntu 17.06.1~ce-0~ubuntu 17.06.2~ce-0~ubuntu 17.09.0~ce-0~ubuntu 17.09.1~ce-0~ubuntu 17.12.0~ce-0~ubuntu 17.12.1~ce-0~ubuntu 18.03.0~ce-0~ubuntu 18.03.1~ce-0~ubuntu 18.06.0~ce~3-0~ubuntu 18.06.1~ce~3-0~ubuntu 18.06.2~ce~3-0~ubuntu 18.06.3~ce~3-0~ubuntu 5:18.09.0~3-0~ubuntu-xenial"

# install each version of docker
for DOCKER_EE_VER in ${DOCKER_EE_VERS}
do
  # install the specific version of docker
  DEBIAN_FRONTEND=noninteractive apt-get install -qq -y --allow-downgrades docker-ce="${DOCKER_EE_VER}" > /dev/null

  # run test w/seccomp disabled
  DISABLE_SECCOMP=true VERBOSE=false ./multi-test.sh 10 40
done

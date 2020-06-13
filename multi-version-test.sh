#!/bin/bash

LIBSECCOMP_VERS="2.4.1-0ubuntu0.16.04.2 2.4.1-0ubuntu0.16.04.2test5"
DOCKER_EE_VERS="17.06.1~ee~1-0~ubuntu 17.06.1~ee~2-0~ubuntu 17.06.2~ee~3-0~ubuntu 17.06.2~ee~4-0~ubuntu 17.06.2~ee~5-0~ubuntu 17.06.2~ee~6-0~ubuntu 3:17.06.2~ee~7~3-0~ubuntu 3:17.06.2~ee~8~3-0~ubuntu 3:17.06.2~ee~10~3-0~ubuntu 3:17.06.2~ee~11~3-0~ubuntu 3:17.06.2~ee~12~3-0~ubuntu 3:17.06.2~ee~13~3-0~ubuntu 3:17.06.2~ee~14~3-0~ubuntu 3:17.06.2~ee~15~3-0~ubuntu 3:17.06.2~ee~16~3-0~ubuntu 3:17.06.2~ee~17~3-0~ubuntu 3:17.06.2~ee~18~3-0~ubuntu 3:17.06.2~ee~19~3-0~ubuntu 3:17.06.2~ee~20~3-0~ubuntu 3:17.06.2~ee~21~3-0~ubuntu 3:17.06.2~ee~22~3-0~ubuntu 3:17.06.2~ee~23~3-0~ubuntu 3:17.06.2~ee~24~3-0~ubuntu 3:17.06.2~ee~25~3-0~ubuntu 5:19.03.0~3-0~ubuntu-xenial 5:19.03.1~3-0~ubuntu-xenial 5:19.03.2~3-0~ubuntu-xenial 5:19.03.3~3-0~ubuntu-xenial 5:19.03.4~3-0~ubuntu-xenial 5:19.03.5~3-0~ubuntu-xenial 5:19.03.8~3-0~ubuntu-xenial"

# install each version of docker
for DOCKER_EE_VER in ${DOCKER_EE_VERS}
do
  # install the specific version of docker
  DEBIAN_FRONTEND=noninteractive apt-get install -qq -y --allow-downgrades docker-ee="${DOCKER_EE_VER}" > /dev/null

  # install each version of libseccomp
  for LIBSECCOMP_VER in ${LIBSECCOMP_VERS}
  do
    # install the specific version of libseccomp2
    DEBIAN_FRONTEND=noninteractive apt-get install -qq -y --allow-downgrades libseccomp2="${LIBSECCOMP_VER}" > /dev/null

    # run test
    DISABLE_SECCOMP=false VERBOSE=false ./multi-test.sh 10 40
  done
done

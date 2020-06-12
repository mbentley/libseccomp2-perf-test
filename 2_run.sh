#!/bin/bash

# output libseccomp2 version
dpkg -l libseccomp2 | grep ^ii
echo

# exec into each container in parallel
for i in $(seq 1 $1)
do 
  /usr/bin/time -f "%E real" docker exec bb$i true &
done

# wait for jobs to complete
while [ "$(jobs)" != "" ]; do jobs > /dev/null; sleep .25; done

#!/bin/bash

echo -n "Launching containers..."

# launch containers
for i in $(seq 1 $1)
do
  docker run -d --name bb$i busybox sleep 3d > /dev/null &
done

# wait for jobs to complete
while [ "$(jobs)" != "" ]; do jobs > /dev/null; sleep .25; done

echo "done"

#!/bin/bash

echo -n "Removing containers..."

# forcefully remove the containers
for i in $(seq 1 $1)
do
  docker rm -f bb$i > /dev/null &
done

# wait for jobs to complete
while [ "$(jobs)" != "" ]; do jobs > /dev/null; sleep .25; done

echo "done"

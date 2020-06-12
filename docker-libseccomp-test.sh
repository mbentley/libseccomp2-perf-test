#!/bin/bash

# set default value to 40 execs
NUM_EXECS="${1:-40}"

# launch test container
echo -n "Launching test container..."
docker run -itd --name test_seccomp busybox /bin/sh > /dev/null
echo "done"

echo -ne "Running exec tests..."

# exec into each container in parallel
for i in $(seq 1 "${NUM_EXECS}")
do
  /usr/bin/time -f "%e" docker exec test_seccomp true 2> "test${i}.txt" &
done

# wait for jobs to complete
while [ "$(jobs)" != "" ]; do jobs > /dev/null; sleep .25; done
echo -e "done\n"

# get clean results to read
for i in $(seq 1 "${NUM_EXECS}")
do
  cat "test${i}.txt" >> results.txt
  rm "test${i}.txt"
done

# output libseccomp2 version
dpkg -l libseccomp2 | grep ^ii | awk '{print $1 "  " $2 " " $3 " " $4}'

# output results
sort -n < results.txt

echo -e "\nMin: $(sort -n < results.txt | head -1)"
echo "Max: $(sort -n < results.txt | tail -1)"
echo "Avg: $(awk '{sum+=$1}END{printf "%0.2f\n",sum/NR}' results.txt)"
rm results.txt

# remove test container
echo -ne "\nStopping and removing test container..."
docker kill test_seccomp > /dev/null
docker rm test_seccomp> /dev/null
echo "done"

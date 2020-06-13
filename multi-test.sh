#!/bin/bash

# set default loops to 10
NUM_LOOPS="${1:-10}"

# set the default number of execs to 40
NUM_EXECS="${2:-40}"

# set default to not disable seccomp on the test container
DISABLE_SECCOMP="${DISABLE_SECCOMP:-false}"

# let user know what test we are doing
echo "Running ${NUM_LOOPS} loops of ${NUM_EXECS} execs"

# loop through the test
for LOOP in $(seq 1 "${NUM_LOOPS}")
do
  echo -e "\nLoop ${LOOP}"
  STATS="$(DISABLE_SECCOMP="${DISABLE_SECCOMP}" ./docker-libseccomp-test.sh "${NUM_EXECS}" | grep -E '(Min:)|(Max:)|(Avg:)')"
  echo "${STATS}" | grep Min >> stats_min.txt
  echo "${STATS}" | grep Max >> stats_max.txt
  echo "${STATS}" | grep Avg >> stats_avg.txt
  echo "${STATS}"
done

# get averages of each stat
echo -e "\nAverage stats from ${NUM_LOOPS} loops of ${NUM_EXECS} execs on docker-ee=$(dpkg -l docker-ee | grep ^ii | awk '{print $3}') for libseccomp2=$(dpkg -l libseccomp2 | grep ^ii | awk '{print $3}') with DISABLE_SECCOMP=${DISABLE_SECCOMP}:"
echo "Avg Min: $(awk '{sum+=$2}END{printf "%0.2f\n",sum/NR}' stats_min.txt)"
echo "Avg Max: $(awk '{sum+=$2}END{printf "%0.2f\n",sum/NR}' stats_max.txt)"
echo "Avg Avg: $(awk '{sum+=$2}END{printf "%0.2f\n",sum/NR}' stats_avg.txt)"

# cleanup
rm stats_min.txt stats_max.txt stats_avg.txt

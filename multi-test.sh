#!/bin/bash

# set default loops to 10
NUM_LOOPS="${1:-10}"

# loop through the test
for LOOP in $(seq 1 "${NUM_LOOPS}")
do
  echo -e "\nLoop ${LOOP}"
  STATS="$(./docker-libseccomp-test.sh 40 | grep -E '(Min:)|(Max:)|(Avg:)')"
  echo "${STATS}" | grep Min >> stats_min.txt
  echo "${STATS}" | grep Max >> stats_max.txt
  echo "${STATS}" | grep Avg >> stats_avg.txt
  echo "${STATS}"
done

# get averages of each stat
echo -e "\nAverage stats from ${NUM_LOOPS} tests on docker-ee=$(dpkg -l docker-ee | grep ^ii | awk '{print $3}') for libseccomp2=$(dpkg -l libseccomp2 | grep ^ii | awk '{print $3}'):"
echo "Avg Min: $(awk '{sum+=$2}END{printf "%0.2f\n",sum/NR}' stats_min.txt)"
echo "Avg Max: $(awk '{sum+=$2}END{printf "%0.2f\n",sum/NR}' stats_max.txt)"
echo "Avg Avg: $(awk '{sum+=$2}END{printf "%0.2f\n",sum/NR}' stats_avg.txt)"

# cleanup
rm stats_min.txt stats_max.txt stats_avg.txt

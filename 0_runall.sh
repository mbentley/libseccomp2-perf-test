#!/bin/bash

# default to 20; allow user to pass 1st arg to set the number of containers
QTY="${1:-20}"

./1_prep.sh "${QTY}"
sleep 5
./2_run.sh "${QTY}"
#sleep 5
./3_clean.sh "${QTY}"

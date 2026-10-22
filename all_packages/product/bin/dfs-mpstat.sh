#!/bin/bash
echo "mpstat -P ALL:"
mpstat -P ALL
printf "\n"
echo "mpstat -I SUM:"
mpstat -I SUM
printf "\n"
printf "\n"
echo "mpstat -I SCPU:"
mpstat -I SCPU


#!/bin/bash
echo "iw dev"
iw dev
printf "\n\f\n"
echo "iw wlan0 link"
iw wlan0 link
printf "\n\f\n"
echo "iw dev wlan0 station dump"
iw dev wlan0 station dump
printf "\n\f\n"
echo "ip -s -d link"
ip -s -d link
printf "\n\f\n"
echo "arp -avD"
arp -avD
printf "\n\f\n"
echo "iw dev wlan0 scan dump"
iw dev wlan0 scan dump



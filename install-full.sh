#!/usr/bin/env bash
export SCRIPT_DIR=`pwd`
echo "Starting installation (FULL)"

echo ">>>> step1"
./install-step1-ncs-api.sh

echo ">>>> step2"
./install-step2-image-classifier.sh

echo ">>>> step3"
./install-step3-opencv.sh

echo ">>>> step4"
./install-step4-webcam.sh

echo "Done installing (FULL)"

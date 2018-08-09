#!/usr/bin/env bash
echo "Starting installation (webcam)"
source ~/.profile

echo ">> Clone streamer repository"
cd ~/workspace/ncappzoo/caffe
git clone 'https://github.com/HanYangZhao/NCS-Pi-Stream'
cd NCS-Pi-Stream

echo ">> Install fswebcam"
sudo apt-get install -y fswebcam

echo ">> Test fswebcam (webcam must be connected already)"
fswebcam image.jpg

echo ">> Restoring swapfile"
sudo cp $SCRIPT_DIR/dphys-swapfile-original /etc/dphys-swapfile
sudo /etc/init.d/dphys-swapfile restart

echo "Done installing (webcam)"

#!/usr/bin/env bash
export SCRIPT_DIR=`pwd`
echo "Starting installation (NCS API)"

echo ">> Installing apt-get dependencies"
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y libusb-1.0-0-dev libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev

echo ">> Enlarging swapfile"
sudo cp $SCRIPT_DIR/dphys-swapfile-enlarged /etc/dphys-swapfile
sudo /etc/init.d/dphys-swapfile restart

echo ">> Workspace creation"
mkdir -p ~/workspace
cd ~/workspace
# See: https://github.com/movidius/ncsdk/blob/master/install.sh
wget https://downloadmirror.intel.com/28192/eng/NCSDK-1.12.01.01.tar.gz
sha256sum -c "ncsdk-1.12.01.01.tar.gz.sha256sum"
tar xvf ncsdk-1.12.01.01.tar.gz
ln -s ncsdk-1.12.01.01 ncsdk

cd ~/workspace/ncsdk/api/src
make && sudo make install

cd ~/workspace
git clone https://github.com/movidius/ncappzoo

cd ncappzoo/apps/hello_ncs_py
python3 hello_ncs.py

echo "Done installing (NCS API)"

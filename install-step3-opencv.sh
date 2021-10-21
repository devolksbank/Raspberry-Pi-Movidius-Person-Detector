#!/usr/bin/env bash
export SCRIPT_DIR=`pwd`
echo "Starting installation (opencv)"
echo "Using tutorial at: https://www.pyimagesearch.com/2017/09/04/raspbian-stretch-install-opencv-3-python-on-your-raspberry-pi/"

echo ">> Installing dependencies"
sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt-get install -y build-essential cmake pkg-config
sudo apt-get install -y libjpeg-dev libtiff5-dev libjasper-dev libpng12-dev
sudo apt-get install -y libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt-get install -y libxvidcore-dev libx264-dev
sudo apt-get install -y libgtk2.0-dev libgtk-3-dev
sudo apt-get install -y libatlas-base-dev gfortran
sudo apt-get install -y python2.7-dev python3-dev

echo ">> Download opencv sources"
cd ~
wget -O opencv-3.3.0.zip https://github.com/Itseez/opencv/archive/3.3.0.zip
sha256sum -c "opencv-3.3.0.zip.sha256sum"
mv opencv-3.3.0.zip opencv.zip
unzip -o opencv.zip

wget -O opencv_contrib-3.3.0.zip https://github.com/Itseez/opencv_contrib/archive/3.3.0.zip
sha256sum -c "opencv_contrib-3.3.0.zip.sha256sum"
mv opencv_contrib-3.3.0.zip opencv_contrib.zip
unzip -o opencv_contrib.zip

echo ">> Create virtualenvironment"
sudo pip install virtualenv virtualenvwrapper
sudo rm -rf ~/.cache/pip

echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python" >> ~/.profile
cat $SCRIPT_DIR/virtualenv-profile-addition >> ~/.profile
source ~/.profile

mkvirtualenv cv -p python3
workon cv

echo ">> Install numpy"
pip install numpy

echo ">> Compile opencv"
cd ~/opencv-3.3.0/
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib-3.3.0/modules \
    -D BUILD_EXAMPLES=ON ..

make -j4
sudo make install
sudo ldconfig

echo ">> Fix library paths"
cd /usr/local/lib/python3.5/site-packages/
sudo mv cv2.cpython-35m-arm-linux-gnueabihf.so cv2.so
cd ~/.virtualenvs/cv/lib/python3.5/site-packages/
ln -s /usr/local/lib/python3.5/site-packages/cv2.so cv2.so

# TODO: test opencv installation
echo "export PYTHONPATH=/usr/local/lib/python3.5/site-packages/" >> ~/.profile
source ~/.profile


echo "Done installing (opencv)"

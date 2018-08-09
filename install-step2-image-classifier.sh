#!/usr/bin/env bash
export SCRIPT_DIR=`pwd`
echo "Starting installation (classifier)"

echo ">> Copying files"
cp $SCRIPT_DIR/graph ~/workspace/ncappzoo/caffe/GoogLeNet/graph
cp $SCRIPT_DIR/synset_words.txt ~/workspace/ncappzoo/data/ilsvrc12/synset_words.txt

echo ">> Installing pip3 dependencies"
pip3 install Cython
pip3 install scikit-image
pip3 install numpy
pip3 install scipy
sudo apt-get install -y libatlas-base-dev

cd ~/workspace/ncappzoo/apps/image-classifier
python3 image-classifier.py 2>/dev/null | grep -i cat

echo "Done installing (classifier)"

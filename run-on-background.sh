#!/usr/bin/env bash
cd ~/workspace/ncappzoo/caffe/NCS-Pi-Stream/

echo "Killing (optional) old process"
touch streamer.pid

kill -9 `cat streamer.pid`

export PYTHONPATH="$PYTHONPATH:/usr/local/lib/python3.5/site-packages"
export PYTHONPATH="$PYTHONPATH:/opt/movidius/caffe/python"

log_prefix=`date +"%Y-%m-%d"`
echo "Starting streamer"
echo "Logging to: $log_prefix.streamer[-err].log"

python3 streamer_ncs.py 1>> $log_prefix.streamer.log 2>> $log_prefix.streamer_err.log &
echo $! > streamer.pid
echo "ProcessID: "`cat streamer.pid`

echo "Done"

#! /bin/bash

location=$1
if [[ "$location" != "palco" && "$location" != "regia" ]]
then
	echo "Usage: $0 [palco|regia]"
	exit 1
fi

curr_dir=$(readlink -f $(dirname $0))
cd ../.config/rncbc.org/
ln -vsf $curr_dir/QjackCtl_$location.conf QjackCtl.conf


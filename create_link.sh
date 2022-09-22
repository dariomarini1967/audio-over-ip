#! /bin/bash

curr_dir=$(readlink -f $(dirname $0))
location=$($curr_dir/palco_or_regia.pl)
if [[ $? -ne 0 ]]
then
	exit
fi
cd ../.config/rncbc.org/
ln -vsf $curr_dir/QjackCtl_$location.conf QjackCtl.conf


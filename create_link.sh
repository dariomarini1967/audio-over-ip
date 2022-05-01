#! /bin/bash

curr_dir=$(readlink -f $(dirname $0))
if [ ! -e ../.config/rncbc.org/QjackCtl.conf ]
then
	echo "QjackCtl.conf not found, is qjackctl available?"
	exit 1
fi
if [ ! -L ../.config/rncbc.org/QjackCtl.conf ]
then
	cp -p ../.config/rncbc.org/QjackCtl.conf .
	cd ../.config/rncbc.org/
	ln -vsf $curr_dir/QjackCtl.conf .
else
	echo symlink already created
fi


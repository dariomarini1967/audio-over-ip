#! /bin/bash -x

cd $(dirname $0)

palco_or_regia=$(./palco_or_regia.pl)
if [[ $? -ne 0 ]]
then
	exit 1
fi

host_palco=$(egrep "^host_palco" ADDRESSES.cfg|cut -d"=" -f2)
host_regia=$(egrep "^host_regia" ADDRESSES.cfg|cut -d"=" -f2)

if [ "$palco_or_regia" == "palco" ]
then
	echo "starting zita for PALCO"
	host_palco=$(ip -br -4 a  | awk '($2=="UP"){gsub("/.+$","",$3);print $3}')
	zita-j2n --jname a_regia $host_regia 4321 2>&1 >>a_regia.log &
	zita-n2j --buff 30 --jname da_regia 0.0.0.0 4322 2>&1 >>da_regia.log 2>&1 &
	pkill -f meterbridge
	meterbridge -n player_meter -t dpm 1 2 3 4 &
else
	echo "starting zita for REGIA"
	host_regia=$(ip -br -4 a  | awk '($2=="UP"){gsub("/.+$","",$3);print $3}')
	zita-n2j --buff 30 --jname da_palco 0.0.0.0 4321 2>&1 >>da_palco.log &
	zita-j2n --jname a_palco $host_palco 4322 2>&1 >>a_palco.log &
fi


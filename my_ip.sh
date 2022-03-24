#! /bin/bash

ip -br a | awk '($2=="UP"){gsub("/.+$","",$3);print $3}'


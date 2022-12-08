#! /bin/bash

watch -n 5 'netstat -anop|egrep ":(4321|4322) "'

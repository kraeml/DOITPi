#!/bin/bash

#SOME COMMANDS YOU WANT TO EXECUTE

function rm_home_pi {
  if grep -r '/home/pi' $1
  then
	  grep -rl '/home/pi' $1 | xargs sed -i 's@/home/pi@/home/'$(getent passwd 1000 | cut --delimiter=: --fields=1)'@g'
  fi
}

rm_home_pi /etc/systemd/system

systemctl disable firstboot.service

rm -rf /etc/systemd/system/firstboot.service
rm -f /firstboot.sh

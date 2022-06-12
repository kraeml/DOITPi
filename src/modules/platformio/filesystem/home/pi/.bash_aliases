alias pio=~/.platformio/penv/bin/pio
alias pio_home="pio home --host=0.0.0.0 --no-open &"
alias platformio=pio

function rm_home_pi {
  if grep -r '/home/pi' $1
  then
	  grep -rl '/home/pi' $1 | xargs sed -i 's@/home/pi@/home/'$USER'@g'
  fi
}

#!/bin/bash

SCREENNUM=`ps -e | grep -c screen`

count=1

TMUXNUM=`ps -e | grep -c tmux`

Reloadtime=10

clear

f=3 b=4

for j in f b; do

  for i in {0..7}; do

    printf -v $j$i %b "\e[${!j}${i}m"

  done

done

rst=$'\e[0m'

bld=$'\e[1m'

echo -e "\e[100m                                   Launcher Script                             \e[00;37;40m"
echo ""

sleep 0.5

cat << EOF

 $f1 'CerNer Team'$rst



EOF

sleep 2

echo ""

echo ""

cat << EOF

 $f1  ▀▄   ▄▀     $f2 ▄▄▄████▄▄▄    $f3  ▄██▄     $f4  ▀▄   ▄▀     $f5 ▄▄▄████▄▄▄    $f6  ▄██▄  $rst

 $f1 ▄█▀███▀█▄    $f2███▀▀██▀▀███   $f3▄█▀██▀█▄   $f4 ▄█▀███▀█▄    $f5███▀▀██▀▀███   $f6▄█▀██▀█▄$rst

 $f1█▀███████▀█   $f2▀▀███▀▀███▀▀   $f3▀█▀██▀█▀   $f4█▀███████▀█   $f5▀▀███▀▀███▀▀   $f6▀█▀██▀█▀$rst

 $f1▀ ▀▄▄ ▄▄▀ ▀   $f2 ▀█▄ ▀▀ ▄█▀    $f3▀▄    ▄▀   $f4▀ ▀▄▄ ▄▄▀ ▀   $f5 ▀█▄ ▀▀ ▄█▀    $f6▀▄    ▄▀$rst

EOF
echo -e "\e[100m                                  CerNer Team                          \e[00;37;40m"


sleep 3.5

cat << EOF

 $bld$f1▄ ▀▄   ▄▀ ▄   $f2 ▄▄▄████▄▄▄    $f3  ▄██▄     $f4▄ ▀▄   ▄▀ ▄   $f5 ▄▄▄████▄▄▄    $f6  ▄██▄  $rst

 $bld$f1█▄█▀███▀█▄█   $f2███▀▀██▀▀███   $f3▄█▀██▀█▄   $f4█▄█▀███▀█▄█   $f5███▀▀██▀▀███   $f6▄█▀██▀█▄$rst

 $bld$f1▀█████████▀   $f2▀▀▀██▀▀██▀▀▀   $f3▀▀█▀▀█▀▀   $f4▀█████████▀   $f5▀▀▀██▀▀██▀▀▀   $f6▀▀█▀▀█▀▀$rst

 $bld$f1 ▄▀     ▀▄    $f2▄▄▀▀ ▀▀ ▀▀▄▄   $f3▄▀▄▀▀▄▀▄   $f4 ▄▀     ▀▄    $f5▄▄▀▀ ▀▀ ▀▀▄▄   $f6▄▀▄▀▀▄▀▄$rst

EOF

sleep 1.5
while true ; do
  for entr in tabchi-*.sh ; do
    entry="${entr/.sh/}"
    tmux kill-session -t $entry
    tmux new-session -d -s $entry "./$entr"
    tmux detach -s $entry

  done

  echo -e ""
  sleep 0.5
  echo -e "$bld$f2 $entr Reloaded : $count $rst"
  sleep $Reloadtime
   let count=count+1
	if [ "$count" == 2400 ]; then

		sync

		sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'

	fi

done
#!/bin/bash

# pre req: 
#   template-ros-core repo is already cloned
#   vpn jass-spb already configured
#   ssh_key file in same directory as script
#   buildAndDeploy script in same directory as script
#   git installed on machine we ssh into

    
ssh -i ssh_key jass@5.19.248.97 -p 2222 << EOF
    mapfile -t fleet < <(avahi-browse -at | grep 'IPv4 DT::PRESENCE::autobot[^ ]*' | grep -o -P '(?<=PRESENCE::).*(?=_duckietown)' | xargs)
    cd template-ros-core
    git checkout demo_24_feb
    git pull
    for bot in ${fleet[@]}; do
        if false && ([ $bot == autobot06 ] || [ $bot == autobot08 ]); then
            echo $bot
            dts devel build -f -H $bot.local
            dts duckiebot demo --demo_name indefinite_navigation --duckiebot_name $bot --package_name duckietown_demos --image duckietown/template-ros-core:demo_24_feb-arm32v7 
        fi
    done
EOF
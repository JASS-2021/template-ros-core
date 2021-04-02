#!/bin/bash

# pre req: 
#   template-ros-core repo is already cloned
#   vpn jass-spb already configured
#   ssh_key file in same directory as script
#   buildAndDeploy script in same directory as script
#   git installed on machine we ssh into

    
ssh -i ssh_key jass@5.19.248.97 -p 2222 << EOF
    mapfile -t fleet < <(avahi-browse -at | grep 'DT::ONLINE::autobot[^ ]*' | grep -o -P '(?<=ONLINE::).*(?=_duckietown)' | xargs)
    cd template-ros-core
    ls
    git pull
    for bot in \${fleet[@]}; do
        echo \$bot
        dts devel build -f -H \$bot.local
        dts duckiebot demo --demo_name circle_drive --duckiebot_name \$bot --package_name circle_drive --image duckietown/template-ros-core:deployment-arm32v7 --debug
    done
EOF
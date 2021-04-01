#!/bin/bash

# pre req: 
#   template-ros-core repo is already cloned
#   vpn jass-spb already configured
#   ssh_key file in same directory as script
#   buildAndDeploy script in same directory as script
#   git installed on machine we ssh into

demo_name=$1
package_name=$2
image_name=$3
    
ssh -i ssh_key jass@5.19.248.97 -p 2222 << EOF
    declare -a fleet=(autobot06 autobot10)
    cd template-ros-core
    ls
    git pull
    for bot in \${fleet[@]}; do
        echo \$bot
        dts devel build -f -H \$bot.local
        dts duckiebot demo --demo_name $1 --duckiebot_name \$bot --package_name $2 --image $3
    done
EOF
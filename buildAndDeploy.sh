#!/bin/bash

duckie_bot=$1
demo_name=$2
package_name=$3
image_name=$4

dts devel build -f -H $duckie_bot.local

dts duckiebot demo --demo_name $demo_name --duckiebot_name $duckie_bot --package_name $package_name --image $image_name --debug

# Example script to run build and deploy in detached screen terminal 
# bash -c "./buildAndDeploy.sh autobot06 indefinite_navigation duckietown_demos duckietown/template-ros-core:demo_24_feb-arm32v7"
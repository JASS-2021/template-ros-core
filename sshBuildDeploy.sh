# if connection output contains success then:
cd template-ros-core
git checkout deployment
git pull
bash -c "./buildAndDeploy.sh autobot06 indefinite_navigation duckietown_demos duckietown/template-ros-core:demo_24_feb-arm32v7"

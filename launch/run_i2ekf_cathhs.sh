#!/bin/bash

source /root/ros1_ws/devel/setup.bash

num_iterations=1  # Change as needed
sequences=(
           "cathhs07" \
           "cathhs08" \
           "cathhs09")

for seq in "${sequences[@]}"; do
    sequence="/root/ros1_ws/src/gptr/scripts/$seq.bag"
    log_dir="/root/ros1_ws/src/I2EKF-LO/cathhs_exp/i2ekf/$seq"
    mkdir -p $log_dir
    echo "Processing sequence: $sequence"
    for ((i=0; i<num_iterations; i++)); do
        echo "Running iteration $i..."
        # Run the experiment on lidar 0
        roslaunch i2ekf_lo livox_mid360_cathhs_lidar0.launch log_file:="$log_dir/i2ekf_lidar0_$i.csv" bag_file:="$sequence"
        # Run the command on lidar 1
        roslaunch i2ekf_lo livox_mid360_cathhs_lidar1.launch log_file:="$log_dir/i2ekf_lidar1_$i.csv" bag_file:="$sequence"
    done
done
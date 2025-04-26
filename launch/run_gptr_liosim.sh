#!/bin/bash

source /root/ros1_ws/devel/setup.bash

num_iterations=5  # Change as needed
sequences=("cloud_avia_mid_w25_dynxtrz_e5" "cloud_avia_mid_w35_dynxtrz_e5" "cloud_avia_mid_w45_dynxtrz_e5")

for seq in "${sequences[@]}"; do
    sequence="/root/ros1_ws/src/gptr/scripts/$seq.bag"
    log_dir="/root/ros1_ws/src/I2EKF-LO/logs/gptr_exp/liosim/$seq"
    mkdir -p $log_dir
    echo "Processing sequence: $sequence"
    for ((i=3; i<num_iterations; i++)); do
        echo "Running iteration $i..."
        # Run the experiment on lidar 0
        roslaunch i2ekf_lo livox_mid360.launch log_file:="$log_dir/i2ekf_lidar0_$i.csv" bag_file:="$sequence"
        # Run the command on lidar 1
        roslaunch i2ekf_lo livox_avia.launch   log_file:="$log_dir/i2ekf_lidar1_$i.csv" bag_file:="$sequence"
    done
done
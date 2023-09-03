#!/bin/bash

set -euo pipefail

trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

{ ./bg_process1.sh || pkill -P $$ ; } & 
p1_pid=$!

{ ./bg_process_exit.sh || pkill -P $$ ; } &
p_exit_pid=$!

{ ./bg_process2.sh || pkill -P $$ ; } &
p2_pid=$!

# check if any of the pids failed, and then stop the others, return the exit code of the failed process

wait $p1_pid $p2_pid $p_exit_pid
#!/usr/bin/env bash
ssh pi@ethpinode1.uanet.edu << "EOF"
  hostname
  date
  screen -dmS ipfs ipfs daemon
EOF
ssh pi@ethpinode2.uanet.edu << "EOF"
  hostname
  date
  screen -dmS ipfs ipfs daemon
EOF
ssh pi@ethpinode3.uanet.edu << "EOF"
  hostname
  date
  screen -dmS ipfs ipfs daemon
EOF
ssh nvidia@10.180.209.249 << "EOF"
  hostname
  date
  screen -dmS ipfs ipfs daemon
EOF

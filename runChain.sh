#!/usr/bin/env bash
ssh pi@ethpinode1.uanet.edu << "EOF"
  hostname
  date
  ipfs swarm peers
  echo "run client1_1"
  screen -dmS chain1 bash ~/privateChain/startminer1_1.sh
  sleep 5
  echo "run client1_2"
  screen -dmS chain2 bash ~/privateChain/startminer1_2.sh
EOF
sleep 5
ssh pi@ethpinode2.uanet.edu << "EOF"
  hostname
  date
  ipfs swarm peers
  echo "run client2_1"
  screen -dmS chain1 bash ~/privateChain/startminer2_1.sh
EOF
sleep 5
ssh pi@ethpinode3.uanet.edu << "EOF"
  hostname
  date
  ipfs swarm peers
  echo "run client3_1"
  screen -dmS chain1 bash ~/privateChain/startminer3_1.sh
EOF
sleep 5
ssh nvidia@10.180.209.249 << "EOF"
  hostname
  date
  ipfs swarm peers
  echo "run client4_1"
  screen -dmS chain1 bash ~/opt/privateChain/startminer4_1.sh
  sleep 5
  echo "run client4_2"
  screen -dmS chain2 bash ~/opt/privateChain/startminer4_2.sh
EOF

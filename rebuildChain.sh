#!/usr/bin/env bash
ssh pi@ethpinode1.uanet.edu << "EOF"
  hostname
  date
  ipfs bootstrap rm --all
  ipfs bootstrap add /ip4/6.0.0.2/tcp/4001/ipfs/QmXbn8pJJSqL4wveJmZ8kgamBGGMEEFjFTqmeAh13KhQ9R
  ipfs bootstrap add /ip4/6.0.0.3/tcp/4001/ipfs/QmQDR3h1eHum51xKtAbHTU4z8yUNTQ273Zu3ENq6yv3EbU
  ipfs bootstrap add /ip4/6.0.0.4/tcp/4001/ipfs/QmQbCdkUymSoVm7MmoBPKTTBt86xpEnAwbwRueCLV3qfna
  rm -rf ~/privateChain/miner1_1/geth/chaindata
  rm -rf ~/privateChain/miner1_1/geth/lightchaindata
  geth --datadir ~/privateChain/miner1_1 init ~/privateChain/poa.json
  rm -rf ~/privateChain/miner1_2/geth/chaindata
  rm -rf ~/privateChain/miner1_2/geth/lightchaindata
  geth --datadir ~/privateChain/miner1_2 init ~/privateChain/poa.json
EOF
ssh pi@ethpinode2.uanet.edu << "EOF"
  hostname
  date
  ipfs bootstrap rm --all
  ipfs bootstrap add /ip4/6.0.0.1/tcp/4001/ipfs/QmSuv8hJg3o73x1WepoRrRsytC68nYFqiMWs273i7fJ1Lh
  ipfs bootstrap add /ip4/6.0.0.3/tcp/4001/ipfs/QmQDR3h1eHum51xKtAbHTU4z8yUNTQ273Zu3ENq6yv3EbU
  ipfs bootstrap add /ip4/6.0.0.4/tcp/4001/ipfs/QmQbCdkUymSoVm7MmoBPKTTBt86xpEnAwbwRueCLV3qfna
  rm -rf ~/privateChain/miner2_1/geth/chaindata
  rm -rf ~/privateChain/miner2_1/geth/lightchaindata
  geth --datadir ~/privateChain/miner2_1 init ~/privateChain/poa.json
  rm -rf ~/privateChain/miner2_2/geth/chaindata
  rm -rf ~/privateChain/miner2_2/geth/lightchaindata
  geth --datadir ~/privateChain/miner2_2 init ~/privateChain/poa.json
EOF
ssh pi@ethpinode3.uanet.edu << "EOF"
  hostname
  date
  ipfs bootstrap rm --all
  ipfs bootstrap add /ip4/6.0.0.1/tcp/4001/ipfs/QmSuv8hJg3o73x1WepoRrRsytC68nYFqiMWs273i7fJ1Lh
  ipfs bootstrap add /ip4/6.0.0.2/tcp/4001/ipfs/QmXbn8pJJSqL4wveJmZ8kgamBGGMEEFjFTqmeAh13KhQ9R
  ipfs bootstrap add /ip4/6.0.0.4/tcp/4001/ipfs/QmQbCdkUymSoVm7MmoBPKTTBt86xpEnAwbwRueCLV3qfna
  rm -rf ~/privateChain/miner3_1/geth/chaindata
  rm -rf ~/privateChain/miner3_1/geth/lightchaindata
  geth --datadir ~/privateChain/miner3_1 init ~/privateChain/poa.json
  rm -rf ~/privateChain/miner3_2/geth/chaindata
  rm -rf ~/privateChain/miner3_2/geth/lightchaindata
  geth --datadir ~/privateChain/miner3_2 init ~/privateChain/poa.json
EOF
ssh nvidia@10.180.209.249 << "EOF"
  hostname
  date
  ipfs bootstrap rm --all
  ipfs bootstrap add /ip4/6.0.0.1/tcp/4001/ipfs/QmSuv8hJg3o73x1WepoRrRsytC68nYFqiMWs273i7fJ1Lh
  ipfs bootstrap add /ip4/6.0.0.2/tcp/4001/ipfs/QmXbn8pJJSqL4wveJmZ8kgamBGGMEEFjFTqmeAh13KhQ9R
  ipfs bootstrap add /ip4/6.0.0.3/tcp/4001/ipfs/QmQDR3h1eHum51xKtAbHTU4z8yUNTQ273Zu3ENq6yv3EbU
  rm -rf ~/opt/privateChain/miner4_1/geth/chaindata
  rm -rf ~/opt/privateChain/miner4_1/geth/lightchaindata
  geth --datadir ~/opt/privateChain/miner4_1 init ~/opt/privateChain/poa.json
  rm -rf ~/opt/privateChain/miner4_2/geth/chaindata
  rm -rf ~/opt/privateChain/miner4_2/geth/lightchaindata
  geth --datadir ~/opt/privateChain/miner4_2 init ~/opt/privateChain/poa.json
EOF
echo "sleep 30 secs"
sleep 30
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
echo "sleep 30 secs"
sleep 30
ssh pi@ethpinode1.uanet.edu << "EOF"
  hostname
  date
  ipfs swarm peers
  screen -dmS chain bash ~/privateChain/startminer1_1.sh
EOF
ssh pi@ethpinode2.uanet.edu << "EOF"
  hostname
  date
  ipfs swarm peers
  screen -dmS chain bash ~/privateChain/startminer2_1.sh
EOF
ssh pi@ethpinode3.uanet.edu << "EOF"
  hostname
  date
  ipfs swarm peers
  screen -dmS chain bash ~/privateChain/startminer3_1.sh
EOF
ssh nvidia@10.180.209.249 << "EOF"
  hostname
  date
  ipfs swarm peers
  screen -dmS chain bash ~/opt/privateChain/startminer4_1.sh
EOF
echo "sleep 30 secs"
sleep 30
ssh nvidia@10.180.209.249 << "EOF"
  hostname
  date
  ipfs swarm peers
  screen -dmS chain bash ~/opt/privateChain/startminer4_1.sh
EOF
ssh pi@ethpinode3.uanet.edu << "EOF"
  hostname
  date
  ipfs swarm peers
  screen -dmS chain bash ~/privateChain/startminer3_1.sh
EOF
ssh pi@ethpinode2.uanet.edu << "EOF"
  hostname
  date
  ipfs swarm peers
  screen -dmS chain bash ~/privateChain/startminer2_1.sh
EOF
ssh pi@ethpinode1.uanet.edu << "EOF"
  hostname
  date
  ipfs swarm peers
  screen -dmS chain bash ~/privateChain/startminer1_1.sh
EOF

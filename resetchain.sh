#!/usr/bin/env bash
ssh pi@ethpinode1.uanet.edu << "EOF"
  rm -rf ~/privateChain/miner1_1/geth/chaindata
  rm -rf ~/privateChain/miner1_1/geth/lightchaindata
  geth --datadir ~/privateChain/miner1_1 init ~/privateChain/poa.json
  rm -rf ~/privateChain/miner1_2/geth/chaindata
  rm -rf ~/privateChain/miner1_2/geth/lightchaindata
  geth --datadir ~/privateChain/miner1_2 init ~/privateChain/poa.json
EOF
ssh pi@ethpinode2.uanet.edu << "EOF"
  rm -rf ~/privateChain/miner2_1/geth/chaindata
  rm -rf ~/privateChain/miner2_1/geth/lightchaindata
  geth --datadir ~/privateChain/miner2_1 init ~/privateChain/poa.json
  rm -rf ~/privateChain/miner2_2/geth/chaindata
  rm -rf ~/privateChain/miner2_2/geth/lightchaindata
  geth --datadir ~/privateChain/miner2_2 init ~/privateChain/poa.json
EOF
ssh pi@ethpinode3.uanet.edu << "EOF"
  rm -rf ~/privateChain/miner3_1/geth/chaindata
  rm -rf ~/privateChain/miner3_1/geth/lightchaindata
  geth --datadir ~/privateChain/miner3_1 init ~/privateChain/poa.json
  rm -rf ~/privateChain/miner3_2/geth/chaindata
  rm -rf ~/privateChain/miner3_2/geth/lightchaindata
  geth --datadir ~/privateChain/miner3_2 init ~/privateChain/poa.json
EOF
ssh nvidia@10.180.209.249 << "EOF"
  rm -rf ~/opt/privateChain/miner4_1/geth/chaindata
  rm -rf ~/opt/privateChain/miner4_1/geth/lightchaindata
  geth --datadir ~/opt/privateChain/miner4_1 init ~/opt/privateChain/poa.json
  rm -rf ~/opt/privateChain/miner4_2/geth/chaindata
  rm -rf ~/opt/privateChain/miner4_2/geth/lightchaindata
  geth --datadir ~/opt/privateChain/miner4_2 init ~/opt/privateChain/poa.json
EOF

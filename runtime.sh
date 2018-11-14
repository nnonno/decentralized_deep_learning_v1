#!/usr/bin/env bash
ssh nvidia@10.180.209.249 << "EOF"
  date
EOF
ssh pi@ethpinode3.uanet.edu << "EOF"
  date
EOF
ssh pi@ethpinode2.uanet.edu << "EOF"
  date
EOF
ssh pi@ethpinode1.uanet.edu << "EOF"
  date
EOF

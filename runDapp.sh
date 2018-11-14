#!/usr/bin/env bash
ssh pi@ethpinode1.uanet.edu << "EOF"
  hostname
  date
  cd nodeAI
  python3 pynode.py d
  scp ~/nodeAI/contractKey.txt pi@ethpinode2.uanet.edu:~/nodeAI/
  scp ~/nodeAI/contractKey.txt pi@ethpinode3.uanet.edu:~/nodeAI/
  scp ~/nodeAI/contractKey.txt nvidia@10.180.209.249:~/opt/nodeAI/
EOF
#   python3 ~/opt/nodeAI/pynode.py v
# EOF
# ssh pi@ethpinode3.uanet.edu << "EOF"
#   hostname
#   date
#   python3 ~/opt/nodeAI/pynode.py c2
# EOF
# ssh pi@ethpinode2.uanet.edu << "EOF"
#   hostname
#   date
#   python3 ~/opt/nodeAI/pynode.py c1
# EOF
# ssh pi@ethpinode1.uanet.edu << "EOF"
#   hostname
#   date
#   python3 ~/opt/nodeAI/pynode.py p
# EOF

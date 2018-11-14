# decentralized_deep_learning_v1

This is a for-fun project to explore the functionality of our dencentralized machine learning testbed.
The testbed consists of mutiple Raspberry PIs and one Jetson TX2. All of them are installed with linux OS based on Debian

Current status:
* Six PIs are used to operate the Software-Defined Network
* Three PIs and one Jetson TX2 are used to conduct distributed computation. Their host information are shown below

```
    Username        Password        Hostname       ipv4(SDN)/NetDevice     domain name or public IP (UAnet)/NetDevice

       pi             123           ethpinode1      6.0.0.1/eth0              ethpinode1.uanet.edu/eth1
       pi             123           ethpinode2      6.0.0.2/eth0              ethpinode2.uanet.edu/eth1
       pi             123           ethpinode3      6.0.0.3/eth0              ethpinode3.uanet.edu/eth1
     nvidia          nvidia        tegra-ubuntu     6.0.0.4/eth0              10.180.209.249/wlan0
```
When testbed is used outside UAkron, the domain name can not be used and you have to figure out the IP address

## Prepare testbed
```
$ bash resetchain.sh
$ bash runipfs.sh
$ bash runChain.sh
$ bash runDapp.sh
```
## testbed simulation
```
pi@ethpinode1:~/nodeAI $ ./pynode.py p
pi@ethpinode2:~/nodeAI $ ./pynode.py c1
pi@ethpinode3:~/nodeAI $ ./pynode.py c2
nvidia@tegra-ubuntu:~/opt/nodeAI$ ./pynode.py v
```
## Todo



## License

MIT (see LICENSE file).

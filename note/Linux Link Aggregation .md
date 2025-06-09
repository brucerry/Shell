# Linux Link Aggregation (a.k.a. network bonding)

Reference:
> https://dic.vbird.tw/linux_server/unit03.php \
> https://www.kernel.org/doc/html/v6.1/networking/bonding.html \
> https://regman1227max.pixnet.net/blog/post/180393508 \
> https://www.kernel.org/doc/Documentation/networking/bonding.txt \
> https://wiki.linuxfoundation.org/networking/bonding \
> https://en.wikipedia.org/wiki/Link_aggregation \
> https://unix.stackexchange.com/questions/696582/bonding-with-vlan-and-bridge-on-debian-11 \

---

## Example: Bonding 2 VLANs from the same logical Ethernet interface

### 1. Check the bridge status
```
> brctl show
bridge name     bridge id               STP enabled     interfaces
br-lan          7fff.88dc971bfcdd       yes             eth0.1
                                                        eth0.2
```

### 2. Check the bonding status
```
> cat /proc/net/bonding/bond0
Ethernet Channel Bonding Driver: v3.7.1 (April 27, 2011)

Bonding Mode: IEEE 802.3ad Dynamic link aggregation
Transmit Hash Policy: layer2 (0)
MII Status: down
MII Polling Interval (ms): 100
Up Delay (ms): 0
Down Delay (ms): 0
Peer Notification Delay (ms): 0
```

### 3. Clean the last bonding setup if needed
```
> ip link set dev bond0 down
> ip link set dev eth0.1 down
> ip link set dev eth0.2 down

> echo -eth0.1 > /sys/class/net/bond0/bonding/slaves
> echo -eth0.2 > /sys/class/net/bond0/bonding/slaves
```

### 4. Reload the original network interfaces
```
> /etc/init.d/network restart
```

### 5. VLANs down
```
> ip link set dev eth0.1 down
> ip link set dev eth0.2 down
```

### 6. Enslave the target VLANs
```
> ip link set master bond0 dev eth0.1
[241332.976350] device eth0.1 left promiscuous mode
[241332.980889] br-lan: port 1(eth0.1) entered disabled state
[241332.987734] bond0: (slave eth0.1): Enslaving as a backup interface with an up link

> ip link set master bond0 dev eth0.2
[241335.965222] device eth0.2 left promiscuous mode
[241335.969774] br-lan: port 2(eth0.2) entered disabled state
[241335.976836] bond0: (slave eth0.2): Enslaving as a backup interface with an up link
```
The below commands may **FAIL** for VLAN interfaces:
```
> echo +eth0.1 > /sys/class/net/bond0/bonding/slaves
> echo +eth0.2 > /sys/class/net/bond0/bonding/slaves

[240021.311608] bond0: (slave eth0.1): Error: Device is in use and cannot be enslaved
[240021.319050] bond0: option slaves: unable to set because the bond device is up
ash: write error: Device or resource busy
```

### 7. Bring up the bonding interfaces and Set bridge
```
> ip link set dev bond0 up
[241377.951915] bond0: Warning: No 802.3ad response from the link partner for any adapters in the bond
[241377.951988] 8021q: adding VLAN 0 to HW filter on device bond0
[241377.966767] IPv6: ADDRCONF(NETDEV_CHANGE): bond0: link becomes ready
[241378.062085] bond0: Warning: No 802.3ad response from the link partner for any adapters in the bond

> ip link set dev eth0.1 up
> ip link set dev eth0.2 up

> brctl addif br-lan bond0
```

### 8. Check the bridge status
```
> brctl show
bridge name     bridge id               STP enabled     interfaces
br-lan          7fff.88dc971bfcdd       yes             bond0
```

### 9. Check the bonding status
```
> cat /proc/net/bonding/bond0
Ethernet Channel Bonding Driver: v3.7.1 (April 27, 2011)

Bonding Mode: IEEE 802.3ad Dynamic link aggregation
Transmit Hash Policy: layer2 (0)
MII Status: up
MII Polling Interval (ms): 100
Up Delay (ms): 0
Down Delay (ms): 0
Peer Notification Delay (ms): 0

802.3ad info
LACP rate: fast
Min links: 0
Aggregator selection policy (ad_select): stable
System priority: 65535
System MAC address: 88:dc:97:1b:fc:dd
Active Aggregator Info:
        Aggregator ID: 21
        Number of ports: 1
        Actor Key: 0
        Partner Key: 1
        Partner Mac Address: 00:00:00:00:00:00

Slave Interface: eth0.1
MII Status: up
Speed: Unknown
Duplex: Unknown
Link Failure Count: 0
Permanent HW addr: 88:dc:97:1b:fc:dd
Slave queue ID: 0
Aggregator ID: 21
Actor Churn State: none
Partner Churn State: churned
Actor Churned Count: 0
Partner Churned Count: 1
details actor lacp pdu:
    system priority: 65535
    system mac address: 88:dc:97:1b:fc:dd
    port key: 0
    port priority: 255
    port number: 1
    port state: 79
details partner lacp pdu:
    system priority: 65535
    system mac address: 00:00:00:00:00:00
    oper key: 1
    port priority: 255
    port number: 1
    port state: 1

Slave Interface: eth0.2
MII Status: up
Speed: Unknown
Duplex: Unknown
Link Failure Count: 0
Permanent HW addr: 88:dc:97:1b:fc:dd
Slave queue ID: 0
Aggregator ID: 22
Actor Churn State: churned
Partner Churn State: churned
Actor Churned Count: 1
Partner Churned Count: 1
details actor lacp pdu:
    system priority: 65535
    system mac address: 88:dc:97:1b:fc:dd
    port key: 0
    port priority: 255
    port number: 2
    port state: 71
details partner lacp pdu:
    system priority: 65535
    system mac address: 00:00:00:00:00:00
    oper key: 1
    port priority: 255
    port number: 1
    port state: 1
```


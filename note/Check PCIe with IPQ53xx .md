#### In u-boot
```
setenv fdtedit0 '/soc/phy@4b0000/%status%?okay'
setenv fdtedit1 '/soc/phy@4b1000/%status%?okay'
setenv fdtedit2 '/soc/phy@4b1800/%status%?okay'
setenv fdtedit3 '/soc/pcie@10000000/%status%?okay'
setenv fdtedit4 '/soc/pcie@18000000/%status%?okay'
setenv fdtedit5 '/soc/pcie@20000000/%status%?okay'
setenv fdtedit6 '/soc/phy@4b1000/%phandle%0xe0'
setenv fdtedit7 '/soc/pcie@18000000/%phys%0xe0'
setenv fdteditnum 8
setenv bootargs $bootargs skip_wifi
save
```
 
#### In kernel
```
cat /proc/bus/pci/devices

0000    17cb1005        ff              10510000                10500000                       0                       0                       0                       0                   0                    1000                   10000                       0                       0                       0                       0                       0
0100    17cb110c        0               12000004                       0                11000004                       0                       0                       0                   0                 2000000                       0                  200000                       0                       0                       0                       0
0000    17cb1005        ff              18510000                18500000                       0                       0                       0                       0                   0                    1000                   10000                       0                       0                       0                       0                       0
0100    17cb110c        0               1a000004                       0                19000004                       0                       0                       0                   0                 2000000                       0                  200000                       0                       0                       0                       0
0000    17cb1005        ff              20510000                20500000                       0                       0                       0                       0                   0                    1000                   10000                       0                       0                       0                       0                       0
0100    17cb110b        0               22000004                       0                21000004                       0                       0                       0                   0                 2000000                       0                  200000                       0                       0                       0                       0
```
| ID       | Meaning      |
| -------- | ------------ |
| 17cb1005 | QCA constant |
| 17cb110c | QCA Waikiki  |
| 17cb110b | QCA York     |

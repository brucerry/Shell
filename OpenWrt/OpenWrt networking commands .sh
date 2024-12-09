# UCI commands
```
uci show
uci show wireless
uci show network
uci set network.lan.proto=dhcp
uci set network.lan.ipaddr=192.168.1.1
uci commit
```

# Restart network
```
/etc/init.d/network restart
```

# Reboot wifi interface
```
wifi (debug related)
wifi load (unload and reload) (debug related)
luci-reload auto wireless (contact with ucitrack)
```

# Set/Get country - available radio channels (Volatile for test only)
```
cfg80211tool wifi2 getCountry
cfg80211tool wifi2 setCountry US
```

# List out available radio channels
```
iw list (show all bands)
iw phy phy2 info (particular bands)
wlanconfig ath2 list chan
iwlist ath2 channel (simplified)
```

# WLAN client connects to host AP/router
```
iw dev ath2 connect -w MY_SSID
iw dev ath2 link (verify connection)
iw dev ath2 disconnect
```

# Add static IP to VIFs
```
ip addr (show all VIFs)
ip addr add <sub-IP>/<mask-len> dev ath2
ip addr show ath2
```

# Ping host
```
ping <host IP>
ping -I ath2 <host IP> (use specific VIF to ping host)
```

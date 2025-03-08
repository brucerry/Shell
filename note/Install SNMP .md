#### Install SNMP in linux
```
sudo apt install -y snmpd snmp libsnmp-dev snmp-mibs-downloader
```

#### Edit the snmpd.conf file
```
sudo vim /etc/snmp/snmpd.conf
```

#### Reload the snmpd service
```
sudo service snmpd restart
```

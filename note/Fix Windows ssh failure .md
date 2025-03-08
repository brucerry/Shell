#### Failed message
```
# PS C:\Users\800548> ssh root@192.168.1.1
# Unable to negotiate with 192.168.1.1 port 22: no matching host key type found. Their offer: ssh-rsa
```

#### Add *C:\Users\Your_User_Name\.ssh\config* file with the below content
```
HostKeyAlgorithms +ssh-rsa
PubkeyAcceptedKeyTypes +ssh-rsa
```

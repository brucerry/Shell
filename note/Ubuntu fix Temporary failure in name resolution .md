Sometimes in Ubuntu: `ping: google.com: Temporary failure in name resolution`

Edit `/etc/resolv.conf` to apply `nameserver 1.1.1.1`

Reload service if necessary:

```
sudo systemctl restart systemd-resolved.service
```

#### Show watchdog status
```
ubus call system watchdog
```

#### Test watchdog
```
echo "Start testing ... " > /dev/kmsg && ubus call system watchdog '{"timeout": 2, "frequency": 1, "stop": true}'
```
# Test software watchdog
# should be rebooted in 2 * 3 = 6 seconds
ubus call system watchdog '{ "frequency": 2 }'
sleep 1
ubus call system watchdog '{ "timeout": 3}'
sleep 1
ubus call system watchdog '{ "stop": true }'

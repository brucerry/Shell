#### Unbind driver
```
echo {interface-name} > /sys/bus/platform/drivers/{driver-name}/unbind

# Example
echo "78b6000.i2c" > /sys/bus/platform/drivers/i2c_qup/unbind
```

#### Bind driver
```
echo {interface-name} > /sys/bus/platform/drivers/{driver-name}/bind

# Example
echo "78b6000.i2c" > /sys/bus/platform/drivers/i2c_qup/bind
```

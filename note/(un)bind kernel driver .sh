# Unbind driver
echo {interface-name} > /sys/bus/platform/drivers/{driver-name}/unbind
# Unbind driver - example
echo "78b6000.i2c" > /sys/bus/platform/drivers/i2c_qup/unbind

# Bind driver
echo {interface-name} > /sys/bus/platform/drivers/{driver-name}/bind
# Bind driver - example
echo "78b6000.i2c" > /sys/bus/platform/drivers/i2c_qup/bind

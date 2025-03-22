## Confirm the I2C interface in u-boot dts

```
/ {
  ...
  ...
  aliases {
    ...
    ...
    i2c0 = "/i2c@78B6000";
  };
  ...
  ...
};
```

## Add I2C libraries in where the u-boot init

```
#include <i2c.h>
#include <dm.h>
```

## Add function for example EMC2303 fan controller

```
static int emc2303_init(void)
{
#define EMC2303_FAN_I2C_BUS 0
#define EMC2303_FAN_I2C_ADDR 0x2c
#define EMC2303_FAN_1_DRIVE_SETTING_REG 0x30
#define EMC2303_FAN_2_DRIVE_SETTING_REG 0x40
#define EMC2303_FAN_3_DRIVE_SETTING_REG 0x50

    struct udevice *bus, *dev;
    int ret = 0;
    uchar value = 0x00;

    ret = uclass_get_device_by_seq(UCLASS_I2C, EMC2303_FAN_I2C_BUS, &bus);
    if (ret) {
        printf("%s(): No I2C Bus %d. Return %d\n", __func__, EMC2303_FAN_I2C_BUS, ret);
        return CMD_RET_FAILURE;
    }
    else {
        printf("%s(): Found I2C Bus %d. Return %d\n", __func__, EMC2303_FAN_I2C_BUS, ret);
    }

    ret = dm_i2c_probe(bus, EMC2303_FAN_I2C_ADDR, 0, &dev);
    if (ret) {
        printf("%s(): Probe I2C Address 0x%02X failed. Return %d\n", __func__, EMC2303_FAN_I2C_ADDR, ret);
        return CMD_RET_FAILURE;
    }
    else {
        printf("%s(): Probe I2C Address 0x%02X success. Return %d\n", __func__, EMC2303_FAN_I2C_ADDR, ret);
    }

    ret = i2c_get_chip(bus, EMC2303_FAN_I2C_ADDR, 1, &dev);
    if (ret) {
        printf("%s(): Get Chip I2C Address 0x%02X failed. Return %d\n", __func__, EMC2303_FAN_I2C_ADDR, ret);
        return CMD_RET_FAILURE;
    }
    else {
        printf("%s(): Get Chip I2C Address 0x%02X success. Return %d\n", __func__, EMC2303_FAN_I2C_ADDR, ret);
    }

    ret = dm_i2c_write(dev, EMC2303_FAN_1_DRIVE_SETTING_REG, &value, 1);
    if (ret) {
        printf("%s(): Write value 0x%02X to register 0x%02X failed. Return %d\n", __func__, value, EMC2303_FAN_1_DRIVE_SETTING_REG, ret);
        return CMD_RET_FAILURE;
    }
    else {
        printf("%s(): Write value 0x%02X to register 0x%02X success. Return %d\n", __func__, value, EMC2303_FAN_1_DRIVE_SETTING_REG, ret);
    }

    ret = dm_i2c_write(dev, EMC2303_FAN_2_DRIVE_SETTING_REG, &value, 1);
    if (ret) {
        printf("%s(): Write value 0x%02X to register 0x%02X failed. Return %d\n", __func__, value, EMC2303_FAN_2_DRIVE_SETTING_REG, ret);
        return CMD_RET_FAILURE;
    }
    else {
        printf("%s(): Write value 0x%02X to register 0x%02X success. Return %d\n", __func__, value, EMC2303_FAN_2_DRIVE_SETTING_REG, ret);
    }

    ret = dm_i2c_write(dev, EMC2303_FAN_3_DRIVE_SETTING_REG, &value, 1);
    if (ret) {
        printf("%s(): Write value 0x%02X to register 0x%02X failed. Return %d\n", __func__, value, EMC2303_FAN_3_DRIVE_SETTING_REG, ret);
        return CMD_RET_FAILURE;
    }
    else {
        printf("%s(): Write value 0x%02X to register 0x%02X success. Return %d\n", __func__, value, EMC2303_FAN_3_DRIVE_SETTING_REG, ret);
    }

    return CMD_RET_SUCCESS;
}
```

## Add execution in code

```
...
emc2303_init();
...
```

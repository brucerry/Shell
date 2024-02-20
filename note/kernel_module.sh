# List existing modules
ls /lib/modules/`uname -r`

# Insert specific module
insmod lib/modules/5.4.55/tso2.ko

# Insert specific module if it's missing
if [ -z "$(lsmod | grep -o tso2)" ]; then
    echo "Module 'tso2' is not loaded."
    echo "Loading Module 'tso2' ..."
    insmod lib/modules/*/tso2.ko
    echo "Module 'tso2' is loaded."
fi

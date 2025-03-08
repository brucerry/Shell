#### Available RAM address
```
root@WGL-600:/# cat proc/iomem
...
...
...
54700000-bfffffff : System RAM
root@WGL-600:/#
```

#### Patch based on the available RAM
```
--- a/qsdk/qca/src/linux-4.4/arch/arm64/boot/dts/qcom/qcom-ipq6018-cp03-c1.dts
+++ b/qsdk/qca/src/linux-4.4/arch/arm64/boot/dts/qcom/qcom-ipq6018-cp03-c1.dts
@@ -105,6 +105,11 @@
                        no-map;
                        reg = <0x0 0x52F00000 0x0 0x01800000>;
                };
+
+        ramoops_ram: ramoops_ram@54700000 {
+            compatible = "ramoops_ram";
+            reg = <0x0 0x54700000 0x0 0x20000>; /* 128kB */
+        };
 #endif
 #endif
        };
--- a/qsdk/qca/src/linux-4.4/fs/pstore/ram.c
+++ b/qsdk/qca/src/linux-4.4/fs/pstore/ram.c
@@ -55,12 +55,12 @@ static ulong ramoops_pmsg_size = MIN_MEM_SIZE;
 module_param_named(pmsg_size, ramoops_pmsg_size, ulong, 0400);
 MODULE_PARM_DESC(pmsg_size, "size of user space message log");

-static ulong mem_address;
+static ulong mem_address = 0x54700000;
 module_param(mem_address, ulong, 0400);
 MODULE_PARM_DESC(mem_address,
                "start of reserved RAM used to store oops/panic logs");

-static ulong mem_size;
+static ulong mem_size = 0x20000;
 module_param(mem_size, ulong, 0400);
 MODULE_PARM_DESC(mem_size,
                "size of reserved RAM used to store oops/panic logs");
--- a/qsdk/target/linux/ipq/config-4.4
+++ b/qsdk/target/linux/ipq/config-4.4
@@ -1,3 +1,13 @@
+CONFIG_PSTORE=y
+CONFIG_PSTORE_FTRACE=y
+CONFIG_PSTORE_PMSG=y
+CONFIG_PSTORE_RAM=y
+CONFIG_PSTORE_CONSOLE=y
+CONFIG_FUNCTION_TRACER=y
+CONFIG_DEBUG_FS=y
+CONFIG_REED_SOLOMON=y
+CONFIG_REED_SOLOMON_ENC8=y
+CONFIG_REED_SOLOMON_DEC8=y
 # CONFIG_AHCI_IPQ is not set
 CONFIG_ALIGNMENT_TRAP=y
 # CONFIG_ALLOW_DEV_COREDUMP is not set
```

#### Verify the pstore/ramoops
```
root@WGL-600:/# ls -al sys/module/pstore/parameters/
drwxr-xr-x    2 root     root             0 Sep 27 05:57 .
drwxr-xr-x    3 root     root             0 Sep 27 05:57 ..
-r--r--r--    1 root     root          4096 Sep 27 05:57 backend
-rw-------    1 root     root          4096 Sep 27 05:57 update_ms
root@WGL-600:/#
root@WGL-600:/# cat sys/module/pstore/parameters/*
ramoops
-1
root@WGL-600:/#
root@WGL-600:/#
root@WGL-600:/# ls -al sys/module/ramoops/parameters/
drwxr-xr-x    2 root     root             0 Sep 27 05:57 .
drwxr-xr-x    3 root     root             0 Sep 27 05:57 ..
-r--------    1 root     root          4096 Sep 27 05:57 console_size
-rw-------    1 root     root          4096 Sep 27 05:57 dump_oops
-rw-------    1 root     root          4096 Sep 27 05:57 ecc
-r--------    1 root     root          4096 Sep 27 05:57 ftrace_size
-r--------    1 root     root          4096 Sep 27 05:57 mem_address
-r--------    1 root     root          4096 Sep 27 05:57 mem_size
-rw-------    1 root     root          4096 Sep 27 05:57 mem_type
-r--------    1 root     root          4096 Sep 27 05:57 pmsg_size
-r--------    1 root     root          4096 Sep 27 05:57 record_size
root@WGL-600:/#
root@WGL-600:/#
root@WGL-600:/# cat sys/module/ramoops/parameters/*
4096
1
0
4096
1416626176
131072
0
4096
4096
root@WGL-600:/#
```

#### Mount pstore, trigger a kernel crash and review ramoops logs
```
root@WGL-600:/# mount -t pstore pstore sys/fs/pstore/
root@WGL-600:/#
root@WGL-600:/# mount
/dev/root on /rom type squashfs (ro,relatime)
proc on /proc type proc (rw,nosuid,nodev,noexec,noatime)
sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,noatime)
cgroup on /sys/fs/cgroup type cgroup (rw,nosuid,nodev,noexec,relatime,cpuset,cpu,cpuacct,blkio,memory,devices,freezer,net_cls,pids)
tmpfs on /tmp type tmpfs (rw,nosuid,nodev,noatime)
/dev/mmcblk0p25 on /overlay type ext4 (rw,noatime,data=ordered)
overlayfs:/overlay on / type overlay (rw,noatime,lowerdir=/,upperdir=/overlay/upper,workdir=/overlay/work)
tmpfs on /dev type tmpfs (rw,nosuid,relatime,size=512k,mode=755)
devpts on /dev/pts type devpts (rw,nosuid,noexec,relatime,mode=600,ptmxmode=000)
/dev/mmcblk0p19 on /lib/firmware/IPQ6018/WIFI_FW type squashfs (ro,relatime)
debugfs on /sys/kernel/debug type debugfs (rw,noatime)
pstore on /sys/fs/pstore type pstore (rw,relatime)
root@WGL-600:/#
root@WGL-600:/# sync
root@WGL-600:/#
root@WGL-600:/#
root@WGL-600:/# echo c > proc/sysrq-trigger
[ 1011.685433] sysrq: SysRq : Trigger a crash
[ 1011.687124] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[ 1011.688605] pgd = db730000
[ 1011.696895] [00000000] *pgd=00000000
...
...
...
root@WGL-600:/#
root@WGL-600:/#
root@WGL-600:/# ls -al sys/fs/pstore/
dr-xr-xr-x    2 root     root             0 Sep 27 05:58 .
drwxr-xr-x    6 root     root             0 Jan  1  1970 ..
root@WGL-600:/#
root@WGL-600:/#
root@WGL-600:/# mount -t pstore pstore sys/fs/pstore/
root@WGL-600:/#
root@WGL-600:/# ls -al sys/fs/pstore/
drwxr-xr-x    2 root     root             0 Sep 27 05:58 .
drwxr-xr-x    6 root     root             0 Jan  1  1970 ..
-r--r--r--    1 root     root          4084 Sep 27 05:58 console-ramoops-0
-r--r--r--    1 root     root          4057 Sep 27 06:00 dmesg-ramoops-0
-r--r--r--    1 root     root          8957 Sep 27 06:00 dmesg-ramoops-1
root@WGL-600:/#
root@WGL-600:/#
root@WGL-600:/#
```

################
#    U-Boot    #
################

> mmc info

    Device: sdhci@7804000
    Manufacturer ID: 11
    OEM: 100
    Name: 008GB
    Tran Speed: 52000000
    Rd Block Len: 512
    MMC version 5.1
    High Capacity: Yes
    Capacity: 7.3 GiB
    Bus Width: 8-bit
    Erase Group Size: 512 KiB
    HC WP Group Size: 4 MiB
    User Capacity: 7.3 GiB WRREL
    Boot Capacity: 4 MiB ENH
    RPMB Capacity: 4 MiB ENH

> mmc part

    Partition Map for MMC device 0  --   Partition Type: EFI
    
    Part    Start LBA       End LBA         Name
            Attributes
            Type GUID
            Partition GUID
      1     0x00000022      0x00003021      "0:HLOS"
            attrs:  0x0000000000000000
            type:   b51f2982-3ebe-46de-8721-ee641e1f9997
            guid:   8c31aaa7-1681-b304-e5b4-fbcef912f75c
      2     0x00003022      0x00006021      "0:HLOS_1"
            attrs:  0x0000000000000000
            type:   a71da577-7f81-4626-b4a2-e377f9174525
            guid:   66c88d51-4f1d-a622-4ee0-80757103842e
      3     0x00006022      0x00024021      "rootfs"
            attrs:  0x0000000000000000
            type:   98d2248d-7140-449f-a954-39d67bd6c3b4
            guid:   cb973550-5096-8d41-f5b6-7e131bae5066
      4     0x00024022      0x00026021      "0:WIFIFW"
            attrs:  0x0000000000000000
            type:   5911fd72-35be-424e-975d-69c957ad3a43
            guid:   b5cb605d-bd12-a810-f0a0-8f483048971f
      5     0x00026022      0x00044021      "rootfs_1"
            attrs:  0x0000000000000000
            type:   5647b280-dc2a-485d-9913-cf53ac40fa32
            guid:   d1205832-893c-ef63-fdab-541b4a30dbb7
      6     0x00044022      0x00046021      "0:WIFIFW_1"
            attrs:  0x0000000000000000
            type:   a640a4e3-6aeb-4d83-81a0-dfeae6b7d1a5
            guid:   019cde0f-a7b6-3f4b-0847-ddcaa0481e7a
      7     0x00046022      0x00086021      "rootfs_data"
            attrs:  0x0000000000000000
            type:   ab1760da-a8bb-4d6f-98d2-9ad3ab9009cd
            guid:   bee2a837-dd8e-95b3-2730-a477de7001eb

> mmc dev

    switch to partitions #0, OK
    mmc0(part 0) is current device

> mmc list

    sdhci@7804000: 0 (eMMC)

> mmc read 0x44000000 0x600 0x10 ## Read eMMC 0x10 blocks (16 * 512 Bytes) data started at the 0x600 block into RAM address 0x44000000

    MMC read: dev # 0, block # 1536, count 16 ... 16 blocks read: OK

> mmc write 0x44000000 0x0 0x100 ## Write 0x100 blocks (256 * 512 Bytes) data started at RAM address 0x44000000 into eMMC started at the 0x0 block

> mmc erase 0x3 0x6 ## Erase 0x6 blocks (6 * 512 Bytes) data started at the 0x3 block of eMMC

################
#    Kernel    #
################

dmesg | grep mmc

    [    2.351115] sdhci_msm 7804000.sdhci: No vmmc regulator found
    [    2.357253] sdhci_msm 7804000.sdhci: No vqmmc regulator found
    [    2.405391] mmc0: SDHCI controller on 7804000.sdhci [7804000.sdhci] using ADMA 64-bit
    [    2.575642] mmc0: MAN_BKOPS_EN bit is not set
    [    2.587960] mmc0: new HS200 MMC card at address 0001
    [    2.588290] mmcblk0: mmc0:0001 008GB1 7.28 GiB
    [    2.592062] mmcblk0rpmb: mmc0:0001 008GB1 partition 3 4.00 MiB
    [    2.602139]  mmcblk0: p1 p2 p3 p4 p5 p6 p7
    [   29.951968] EXT4-fs (mmcblk0p7): mounted filesystem with ordered data mode. Opts: (null)
    # HS200 is eMMC bus speed mode, 200MB/s
    # mmc0:0001 008GB1 7.28 GiB has to be matched with the datasheet / eMMC spec.

cd /sys/class/mmc_host/mmc0/mmc0:0001
# CID Register
cat cid
    110100303038474231006dbd1141a900
# Decode specific fields of CID
cat manfid
    0x000011
cat oemid
    0x0100
cat name
    008GB1
cat serial
    0x6dbd1141
cat date
    10/2022

cd /sys/class/mmc_host/mmc0/mmc0:0001/block/mmcblk0
# Get size
cat size
    15269888 # 15269888 is sector size. So its available size = 15269888 * 512 = 7818182656 = 7.28125 GiB

# Dump eMMC
cd /tmp
# rm -rf /overlay/*
cat /dev/mmcblk0 | gzip -c - > /tmp/eMMC_flashdump.gzip
tftp -p 192.168.1.10 -l /tmp/eMMC_flashdump.gzip -r eMMC_flashdump.gzip

# Flash eMMC
cd /tmp
tftp -g 192.168.1.10 -l eMMC_flashdump.gzip
zcat eMMC_flashdump.gzip | dd of=/dev/mmcblk0 bs=512k ; sync


#######################
#    Backup Example   #
#######################

dd if=/dev/mmcblk0p1  of=SBL1.bin && tftp -p 192.168.1.10 -l SBL1.bin
dd if=/dev/mmcblk0p2  of=BOOTCONFIG.bin && tftp -p 192.168.1.10 -l BOOTCONFIG.bin
dd if=/dev/mmcblk0p3  of=BOOTCONFIG1.bin && tftp -p 192.168.1.10 -l BOOTCONFIG1.bin
dd if=/dev/mmcblk0p4  of=QSEE.bin && tftp -p 192.168.1.10 -l QSEE.bin
dd if=/dev/mmcblk0p5  of=QSEE_1.bin && tftp -p 192.168.1.10 -l QSEE_1.bin
dd if=/dev/mmcblk0p6  of=DEVCFG.bin && tftp -p 192.168.1.10 -l DEVCFG.bin
dd if=/dev/mmcblk0p7  of=DEVCFG_1.bin && tftp -p 192.168.1.10 -l DEVCFG_1.bin
dd if=/dev/mmcblk0p8  of=RPM.bin && tftp -p 192.168.1.10 -l RPM.bin
dd if=/dev/mmcblk0p9  of=RPM_1.bin && tftp -p 192.168.1.10 -l RPM_1.bin
dd if=/dev/mmcblk0p10 of=CDT.bin && tftp -p 192.168.1.10 -l CDT.bin
dd if=/dev/mmcblk0p11 of=CDT_1.bin && tftp -p 192.168.1.10 -l CDT_1.bin
dd if=/dev/mmcblk0p12 of=APPSBLENV.bin && tftp -p 192.168.1.10 -l APPSBLENV.bin
dd if=/dev/mmcblk0p13 of=APPSBL.bin && tftp -p 192.168.1.10 -l APPSBL.bin
dd if=/dev/mmcblk0p14 of=APPSBL_1.bin && tftp -p 192.168.1.10 -l APPSBL_1.bin
dd if=/dev/mmcblk0p15 of=ART.bin && tftp -p 192.168.1.10 -l ART.bin
dd if=/dev/mmcblk0p16 of=HLOS.bin && tftp -p 192.168.1.10 -l HLOS.bin
dd if=/dev/mmcblk0p17 of=HLOS_1.bin && tftp -p 192.168.1.10 -l HLOS_1.bin
dd if=/dev/mmcblk0p19 of=WIFIFW.bin && tftp -p 192.168.1.10 -l WIFIFW.bin
dd if=/dev/mmcblk0p21 of=WIFIFW_1.bin && tftp -p 192.168.1.10 -l WIFIFW_1.bin
dd if=/dev/mmcblk0p22 of=ETHPHYFW.bin && tftp -p 192.168.1.10 -l ETHPHYFW.bin
cat /dev/mmcblk0p18 | gzip -c - > /tmp/rootfs.gzip  && tftp -p 192.168.1.10 -l rootfs.gzip
cat /dev/mmcblk0p20 | gzip -c - > /tmp/rootfs_1.gzip  && tftp -p 192.168.1.10 -l rootfs_1.gzip
cat /dev/mmcblk0 | gzip -c - > celer_emmc.gzip && tftp -p 192.168.1.10 -l celer_emmc.gzip

cd /tmp
cat /etc/version > version.txt
tftp -p 192.168.1.10 -l version.txt
ifconfig > ifconfig.txt
tftp -p 192.168.1.10 -l ifconfig.txt
iwconfig > iwconfig.txt
tftp -p 192.168.1.10 -l iwconfig.txt
dmesg > dmesg.txt
tftp -p 192.168.1.10 -l dmesg.txt
fw_printenv > fw_printenv.txt
tftp -p 192.168.1.10 -l fw_printenv.txt


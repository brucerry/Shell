##################
#    Example 1   #
##################

256MB NAND (2K + 128) (8-bit ECC)

```
dd if=/dev/zero ibs=128k count=480  | tr '\000' '\377' > out1.pad
dd if=/dev/zero ibs=128k count=480  | tr '\000' '\377' > out2.pad
dd if=/dev/zero ibs=128k count=1088 | tr '\000' '\377' > out3.pad

dd if=openwrt-ipq-ipq60xx-ubi-root.img of=out1.pad conv=notrunc

./img_gen out1.pad -h -8 -O 128 -o out1.ecc
./img_gen out2.pad -h -8 -O 128 -o out2.ecc
./img_gen out3.pad -h -8 -O 128 -o out3.ecc

cat out1.ecc out2.ecc out3.ecc > MW09_nand_272MB.bin
```

##################
#    Example 2   #
##################

512MB NAND (2K + 64) (4-bit ECC)

```
dd if=/dev/zero ibs=128k count=416  | tr '\000' '\377' > rootfs.pad
dd if=/dev/zero ibs=128k count=64   | tr '\000' '\377' > WIFIFW.pad
dd if=/dev/zero ibs=128k count=416  | tr '\000' '\377' > rootfs_1.pad
dd if=/dev/zero ibs=128k count=64   | tr '\000' '\377' > WIFIFW_1.pad
dd if=/dev/zero ibs=128k count=3136 | tr '\000' '\377' > empty.pad

dd if=openwrt-ipq807x-ipq807x_32-ubi-root.img of=rootfs.pad conv=notrunc
dd if=wifi_fw_ubi_v2.img of=WIFIFW.pad conv=notrunc

./img_gen rootfs.pad   -h -4 -o out1.ecc
./img_gen WIFIFW.pad   -h -4 -o out2.ecc
./img_gen rootfs_1.pad -h -4 -o out3.ecc
./img_gen WIFIFW_1.pad -h -4 -o out4.ecc
./img_gen empty.pad    -h -4 -o out5.ecc

cat out1.ecc out2.ecc out3.ecc out4.ecc out5.ecc > MW08_nand_528MB.bin
```

##################
#    Example 3   #
##################

128MB NAND (2K + 64) (4-bit ECC)

```
dd if=/dev/zero ibs=128k count=4   | tr '\000' '\377' > SBL1.pad
dd if=/dev/zero ibs=128k count=4   | tr '\000' '\377' > MIBIB.pad
dd if=/dev/zero ibs=128k count=2   | tr '\000' '\377' > BOOTCONFIG.pad
dd if=/dev/zero ibs=128k count=2   | tr '\000' '\377' > BOOTCONFIG1.pad
dd if=/dev/zero ibs=128k count=8   | tr '\000' '\377' > QSEE.pad
dd if=/dev/zero ibs=128k count=8   | tr '\000' '\377' > QSEE_1.pad
dd if=/dev/zero ibs=128k count=2   | tr '\000' '\377' > DEVCFG.pad
dd if=/dev/zero ibs=128k count=2   | tr '\000' '\377' > DEVCFG_1.pad
dd if=/dev/zero ibs=128k count=2   | tr '\000' '\377' > CDT.pad
dd if=/dev/zero ibs=128k count=2   | tr '\000' '\377' > CDT_1.pad
dd if=/dev/zero ibs=128k count=4   | tr '\000' '\377' > APPSBLENV.pad
dd if=/dev/zero ibs=128k count=10  | tr '\000' '\377' > APPSBL.pad
dd if=/dev/zero ibs=128k count=10  | tr '\000' '\377' > APPSBL_1.pad
dd if=/dev/zero ibs=128k count=8   | tr '\000' '\377' > ART.pad
dd if=/dev/zero ibs=128k count=4   | tr '\000' '\377' > TRAINING.pad
dd if=/dev/zero ibs=128k count=464 | tr '\000' '\377' > rootfs.pad
dd if=/dev/zero ibs=128k count=464 | tr '\000' '\377' > rootfs_1.pad
dd if=/dev/zero ibs=128k count=24  | tr '\000' '\377' > empty.pad

dd if=sbl1_nand.mbn of=SBL1.pad conv=notrunc
dd if=nand-system-partition-ipq5018.bin of=MIBIB.pad conv=notrunc
dd if=bootconfig.bin of=BOOTCONFIG.pad conv=notrunc
dd if=bootconfig.bin of=BOOTCONFIG1.pad conv=notrunc
dd if=tz.mbn of=QSEE.pad conv=notrunc
dd if=devcfg.mbn of=DEVCFG.pad conv=notrunc
dd if=cdt-AP-MP03.3_256M16_DDR3.bin of=CDT.pad conv=notrunc
# dd if=APPSBLENV.bin of=APPSBLENV.pad conv=notrunc
dd if=openwrt-ipq5018-u-boot.mbn of=APPSBL.pad conv=notrunc
dd if=openwrt-ipq-ipq50xx-ubi-root.img of=rootfs.pad conv=notrunc

./img_gen SBL1.pad        -h -4 -o SBL1.ecc
./img_gen MIBIB.pad       -h -4 -o MIBIB.ecc
./img_gen BOOTCONFIG.pad  -h -4 -o BOOTCONFIG.ecc
./img_gen BOOTCONFIG1.pad -h -4 -o BOOTCONFIG1.ecc
./img_gen QSEE.pad        -h -4 -o QSEE.ecc
./img_gen QSEE_1.pad      -h -4 -o QSEE_1.ecc
./img_gen DEVCFG.pad      -h -4 -o DEVCFG.ecc
./img_gen DEVCFG_1.pad    -h -4 -o DEVCFG_1.ecc
./img_gen CDT.pad         -h -4 -o CDT.ecc
./img_gen CDT_1.pad       -h -4 -o CDT_1.ecc
./img_gen APPSBLENV.pad   -h -4 -o APPSBLENV.ecc
./img_gen APPSBL.pad      -h -4 -o APPSBL.ecc
./img_gen APPSBL_1.pad    -h -4 -o APPSBL_1.ecc
./img_gen ART.pad         -h -4 -o ART.ecc
./img_gen TRAINING.pad    -h -4 -o TRAINING.ecc
./img_gen rootfs.pad      -h -4 -o rootfs.ecc
./img_gen rootfs_1.pad    -h -4 -o rootfs_1.ecc
./img_gen empty.pad       -h -4 -o empty.ecc

cat SBL1.ecc MIBIB.ecc BOOTCONFIG.ecc BOOTCONFIG1.ecc \
QSEE.ecc QSEE_1.ecc DEVCFG.ecc DEVCFG_1.ecc CDT.ecc CDT_1.ecc \
APPSBLENV.ecc APPSBL.ecc APPSBL_1.ecc ART.ecc TRAINING.ecc rootfs.ecc \
rootfs_1.ecc empty.ecc > ECW200_NAND_132MB.bin
```

##################
#    Example 4   #
##################

512MB NAND (4K + 256) (8-bit ECC)

```
dd if=/dev/zero ibs=128k count=4    | tr '\000' '\377' > TRAINING.pad
dd if=/dev/zero ibs=128k count=2    | tr '\000' '\377' > LICENSE.pad
dd if=/dev/zero ibs=128k count=668  | tr '\000' '\377' > rootfs.pad
dd if=/dev/zero ibs=128k count=668  | tr '\000' '\377' > rootfs_1.pad
dd if=/dev/zero ibs=128k count=24   | tr '\000' '\377' > NVRAM.pad
dd if=/dev/zero ibs=128k count=2730 | tr '\000' '\377' > empty.pad

dd if=openwrt-ipq95xx-ipq95xx_32-ubi-root-m4096-p256KiB.img of=rootfs.pad conv=notrunc

./img_gen TRAINING.pad  -b -e -8 -O 256 -o TRAINING.ecc
./img_gen LICENSE.pad   -b -e -8 -O 256 -o LICENSE.ecc
./img_gen rootfs.pad    -b -e -8 -O 256 -o rootfs.ecc
./img_gen rootfs_1.pad  -b -e -8 -O 256 -o rootfs_1.ecc
./img_gen NVRAM.pad     -b -e -8 -O 256 -o NVRAM.ecc
./img_gen empty.pad     -b -e -8 -O 256 -o empty.ecc

cat TRAINING.ecc LICENSE.ecc rootfs.ecc rootfs_1.ecc NVRAM.ecc empty.ecc > AP750_NAND_544MB.bin
```

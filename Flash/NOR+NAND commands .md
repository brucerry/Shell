## U-Boot 

### Partitions

#### Read out partition from NOR
```
sf probe && sf read 0x44000000 0xf80000 0x80000 && tftpput 0x44000000 0x80000 ART.bin
```

#### Read out partition from NAND
```
nand read 0x44000000 0xf80000 0x80000 && tftpput 0x44000000 0x80000 ART.bin
```

#### Write in partition to NOR
```
tftpboot 0x44000000 ART.bin && sf probe && sf erase 0xf80000 0x80000 && sf write 0x44000000 0xf80000 $filesize
```

#### Write in partition to NAND
```
tftpboot 0x44000000 ART.bin && nand erase 0xf80000 0x80000 && nand write 0x44000000 0xf80000 $filesize
```

### Entire NOR

#### Read out 8MB NOR
```
sf probe && sf read 0x44000000 0x0 0x800000 && tftpput 0x44000000 0x800000 NOR_8MB.bin
```

#### Read out 16MB NOR
```
sf probe && sf read 0x44000000 0x0 0x1000000 && tftpput 0x44000000 0x1000000 NOR_16MB.bin
```

#### Read out 32MB NOR
```
sf probe && sf read 0x44000000 0x0 0x2000000 && tftpput 0x44000000 0x2000000 NOR_32MB.bin
```

#### Read out 64MB NOR
```
sf probe && sf read 0x44000000 0x0 0x4000000 && tftpput 0x44000000 0x4000000 NOR_64MB.bin
```

#### Write in 8MB NOR
```
tftpboot 0x44000000 NOR_8MB.bin
sf probe && sf erase 0x0 0x800000 && sf write 0x44000000 0x0 0x800000
```

#### Write in 16MB NOR
```
tftpboot 0x44000000 NOR_16MB.bin
sf probe && sf erase 0x0 0x1000000 && sf write 0x44000000 0x0 0x1000000
```

#### Write in 32MB NOR
```
tftpboot 0x44000000 NOR_32MB.bin
sf probe && sf erase 0x0 0x2000000 && sf write 0x44000000 0x0 0x2000000
```

#### Write in 64MB NOR
```
tftpboot 0x44000000 NOR_64MB.bin
sf probe && sf erase 0x0 0x4000000 && sf write 0x44000000 0x0 0x4000000
```

### Entire NAND

#### Read out 256MB + spare NAND (2k+64 bytes/page)
```
tftpboot 0x52000000 ff_66M && tftpboot 0x56200000 ff_66M && nand read.raw 0x52000000 0x0 0x10000 && tftpput 0x52000000 0x8400000 NAND_132MB.bin
tftpboot 0x52000000 ff_66M && tftpboot 0x56200000 ff_66M && nand read.raw 0x52000000 0x8000000 0x10000 && tftpput 0x52000000 0x8400000 NAND_132MB_2.bin
```

#### Read out 1GB NAND + spare NAND (2k+64 bytes/page)
```
tftpboot 0x52000000 ff_66M && tftpboot 0x56200000 ff_66M && nand read.raw 0x52000000 0x0 0x10000 && tftpput 0x52000000 0x8400000 NAND_132MB.bin
tftpboot 0x52000000 ff_66M && tftpboot 0x56200000 ff_66M && nand read.raw 0x52000000 0x8000000 0x10000 && tftpput 0x52000000 0x8400000 NAND_132MB_2.bin
tftpboot 0x52000000 ff_66M && tftpboot 0x56200000 ff_66M && nand read.raw 0x52000000 0x10000000 0x10000 && tftpput 0x52000000 0x8400000 NAND_132MB_3.bin
tftpboot 0x52000000 ff_66M && tftpboot 0x56200000 ff_66M && nand read.raw 0x52000000 0x18000000 0x10000 && tftpput 0x52000000 0x8400000 NAND_132MB_4.bin
tftpboot 0x52000000 ff_66M && tftpboot 0x56200000 ff_66M && nand read.raw 0x52000000 0x20000000 0x10000 && tftpput 0x52000000 0x8400000 NAND_132MB_5.bin
tftpboot 0x52000000 ff_66M && tftpboot 0x56200000 ff_66M && nand read.raw 0x52000000 0x28000000 0x10000 && tftpput 0x52000000 0x8400000 NAND_132MB_6.bin
tftpboot 0x52000000 ff_66M && tftpboot 0x56200000 ff_66M && nand read.raw 0x52000000 0x30000000 0x10000 && tftpput 0x52000000 0x8400000 NAND_132MB_7.bin
tftpboot 0x52000000 ff_66M && tftpboot 0x56200000 ff_66M && nand read.raw 0x52000000 0x38000000 0x10000 && tftpput 0x52000000 0x8400000 NAND_132MB_8.bin
```

#### Write in multiple nand dumps to device (2k+64 bytes/page)
```
nand erase.chip
tftpboot 0x52000000 NAND_132MB_1.bin && nand write.raw 0x52000000 0x0 0x10000
tftpboot 0x52000000 NAND_132MB_2.bin && nand write.raw 0x52000000 0x8000000 0x10000
tftpboot 0x52000000 NAND_132MB_3.bin && nand write.raw 0x52000000 0x10000000 0x10000
tftpboot 0x52000000 NAND_132MB_4.bin && nand write.raw 0x52000000 0x18000000 0x10000
tftpboot 0x52000000 NAND_132MB_5.bin && nand write.raw 0x52000000 0x20000000 0x10000
tftpboot 0x52000000 NAND_132MB_6.bin && nand write.raw 0x52000000 0x28000000 0x10000
tftpboot 0x52000000 NAND_132MB_7.bin && nand write.raw 0x52000000 0x30000000 0x10000
tftpboot 0x52000000 NAND_132MB_8.bin && nand write.raw 0x52000000 0x38000000 0x10000
```

#### Check number of nand bad blocks
```
nand bad
```

#### Clean up nand bad blocks record (and chip info) * *not recommended to do so* *
```
nand scrub.chip
```
################
#    U-Boot    #
################

tftpboot 0x44000000 single-image.img
imgaddr=44000000 && source $imgaddr:script

################
################

# read out partition from NOR
sf probe && sf read 0x44000000 0xf80000 0x80000 && tftpput 0x44000000 0x80000 ART.bin

# read out partition from NAND
nand read 0x44000000 0xf80000 0x80000 && tftpput 0x44000000 0x80000 ART.bin

# write in partition to NOR
tftpboot 0x44000000 ART.bin && sf probe && sf erase 0xf80000 0x80000 && sf write 0x44000000 0xf80000 $filesize

# write in partition to NAND
tftpboot 0x44000000 ART.bin && nand erase 0xf80000 0x80000 && nand write 0x44000000 0xf80000 $filesize

################
################

# read out 8MB NOR
sf probe && sf read 0x44000000 0x0 0x800000 && tftpput 0x44000000 0x800000 NOR_8MB.bin

# read out 32MB NOR
sf probe && sf read 0x44000000 0x0 0x2000000 && tftpput 0x44000000 0x2000000 NOR_32MB.bin


# write in 8MB NOR
tftpboot 0x44000000 NOR_8MB.bin
sf probe && sf erase 0x0 0x800000 && sf write 0x44000000 0x0 0x800000

# write in 32MB NOR
tftpboot 0x44000000 NOR_32MB.bin
sf probe && sf erase 0x0 0x2000000 && sf write 0x44000000 0x0 0x2000000

################
################

# read out 256MB + spare NAND (2k+64 bytes/page)
tftpboot 0x52000000 ff_66M && tftpboot 0x56200000 ff_66M && nand read.raw 0x52000000 0x0 0x10000 && tftpput 0x52000000 0x8400000 NAND_132MB.bin
tftpboot 0x52000000 ff_66M && tftpboot 0x56200000 ff_66M && nand read.raw 0x52000000 0x8000000 0x10000 && tftpput 0x52000000 0x8400000 NAND_132MB_2.bin

# read out 1GB NAND + spare NAND (2k+64 bytes/page)
tftpboot 0x52000000 ff_66M && tftpboot 0x56200000 ff_66M && nand read.raw 0x52000000 0x0 0x10000 && tftpput 0x52000000 0x8400000 NAND_132MB.bin
tftpboot 0x52000000 ff_66M && tftpboot 0x56200000 ff_66M && nand read.raw 0x52000000 0x8000000 0x10000 && tftpput 0x52000000 0x8400000 NAND_132MB_2.bin
tftpboot 0x52000000 ff_66M && tftpboot 0x56200000 ff_66M && nand read.raw 0x52000000 0x10000000 0x10000 && tftpput 0x52000000 0x8400000 NAND_132MB_3.bin
tftpboot 0x52000000 ff_66M && tftpboot 0x56200000 ff_66M && nand read.raw 0x52000000 0x18000000 0x10000 && tftpput 0x52000000 0x8400000 NAND_132MB_4.bin
tftpboot 0x52000000 ff_66M && tftpboot 0x56200000 ff_66M && nand read.raw 0x52000000 0x20000000 0x10000 && tftpput 0x52000000 0x8400000 NAND_132MB_5.bin
tftpboot 0x52000000 ff_66M && tftpboot 0x56200000 ff_66M && nand read.raw 0x52000000 0x28000000 0x10000 && tftpput 0x52000000 0x8400000 NAND_132MB_6.bin
tftpboot 0x52000000 ff_66M && tftpboot 0x56200000 ff_66M && nand read.raw 0x52000000 0x30000000 0x10000 && tftpput 0x52000000 0x8400000 NAND_132MB_7.bin
tftpboot 0x52000000 ff_66M && tftpboot 0x56200000 ff_66M && nand read.raw 0x52000000 0x38000000 0x10000 && tftpput 0x52000000 0x8400000 NAND_132MB_8.bin


# write in 2 nanddump to device
tftpboot 0x52000000 NAND_132MB.bin
nand erase.chip && nand write.raw 0x52000000 0x0 0x10000
tftpboot 0x52000000 NAND_132MB_2.bin
nand write.raw 0x52000000 0x8000000 0x10000

################
################

# check number of nand bad blocks
nand bad

# clear nand bad blocks record (and chip info) **not recommended to do so**
nand scrub.chip


> In case the patches have to be applied during compile time instead of just modifying the code manually

#### Install quilt
```
apt install quilt -y
```

#### Create patch
```
cd ${Root}/qsdk/
make package/boot/uboot-envtools/{clean,prepare} V=s -j1 QUILT=1
cd ${Root}/qsdk/build_dir/target*/u-boot-2014.10/
quilt push -a
quilt new 400-fw_printenv-support-MLCNANDFLASH.patch
quilt add tools/env/fw_env.c
vim tools/env/fw_env.c   # Edit and save your code here
quilt diff
quilt refresh
```

#### Allocate patch
```
cp patches/400-fw_printenv-support-MLCNANDFLASH.patch ${Root}/qsdk/package/boot/uboot-envtools/patches/
```

#### Test compile
cd ${Root}/qsdk/ \
make package/boot/uboot-envtools/{clean,compile} V=s -j1

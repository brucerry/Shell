apt install quilt -y

cd ${Root}/qsdk/
make package/boot/uboot-envtools/{clean,prepare} V=s QUILT=1
cd ${Root}/qsdk/build_dir/target*/u-boot-2014.10/
quilt push -a
quilt new 400-fw_printenv-support-MLCNANDFLASH.patch
quilt add tools/env/fw_env.c
vim tools/env/fw_env.c
quilt diff
quilt refresh

cp patches/400-fw_printenv-support-MLCNANDFLASH.patch ${Root}/qsdk/package/boot/uboot-envtools/patches/

cd ${Root}/qsdk/
make package/boot/uboot-envtools/clean
make package/boot/uboot-envtools/compile

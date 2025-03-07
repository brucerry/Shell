## Windows PowerShell

#### List WSL2 Linux distributions
```
wsl -l -v

      NAME                   STATE           VERSION
    * Ubuntu                 Stopped         2
      docker-desktop-data    Running         2
      docker-desktop         Running         2
```

#### Search for 'ext4.vhdx' files and 'docker_data.vhdx' files
```
"C:\Users\user\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu_79rhkp1fndgsc\LocalState\ext4.vhdx"         7.00GB
"C:\Users\user\AppData\Local\Docker\wsl\distro\ext4.vhdx"                                                      146MB
"C:\Users\user\AppData\Local\Docker\wsl\data\ext4.vhdx"                                                        23.4GB
```

#### Backup WSL2 Linux distributions
```
wsl --shutdown
wsl --export Ubuntu C:\Users\user\Ubuntu_backup.tar
wsl --export docker-desktop-data C:\Users\user\docker-desktop-data_backup.tar
wsl --export docker-desktop C:\Users\user\docker-desktop_backup.tar
```

#### Run diskpart
```
wsl --shutdown
diskpart
```

#### In diskpart CLI, release target space
```
select vdisk file="C:\Users\user\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu_79rhkp1fndgsc\LocalState\ext4.vhdx"
compact vdisk
detach vdisk
select vdisk file="C:\Users\user\AppData\Local\Docker\wsl\data\ext4.vhdx"
compact vdisk
detach vdisk
```

#### 2024-09-09 updated
The virtual disks are installed at:
- C:\Users\user\AppData\Local\Docker\wsl\main\ext4.vhdx
- C:\Users\user\AppData\Local\Docker\wsl\disk\docker_data.vhdx

#### 2024-11-14 updated
```
wsl --shutdown
diskpart
select vdisk file="C:\Users\user\AppData\Local\Docker\wsl\disk\docker_data.vhdx"
attach vdisk readonly
compact vdisk
detach vdisk
```
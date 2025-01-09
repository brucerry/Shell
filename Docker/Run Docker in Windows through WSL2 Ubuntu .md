> Reference: https://hackmd.io/@OmniXRI-Jack/wsl2_ubuntu_xlaunch_docker_openvino_dlstreamer

---

## In Windows PowerShell

#### Install WSL2 with default Linux distribution
Or you may install it through Microsoft Store in Win11
```
wsl --list
wsl --list --online
wsl --install -d Ubuntu-24.04
```

#### VHDX default location
Depends on the installed version
```
C:\Users\user\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu24.04LTS_79rhkp1fndgsc\LocalState\ext4.vhdx
```

---

## In WSL Ubuntu CLI

You may be asked to create a user account as default, let's say "bruce"

#### *[Optional] Install OpenCL to enhance Intel performance*
```
cd ~
sudo apt-get update
sudo apt install ocl-icd-opencl-dev
```

#### *[Optional] Install Intel packages: intel-gmmlib, intel-opencl-icd, intel-level-zero-gpu*
```
cd ~
mkdir neo
cd neo
wget https://github.com/intel/intel-graphics-compiler/releases/download/igc-1.0.12037.1/intel-igc-core_1.0.12037.1_amd64.deb
wget https://github.com/intel/intel-graphics-compiler/releases/download/igc-1.0.12037.1/intel-igc-opencl_1.0.12037.1_amd64.deb
wget https://github.com/intel/compute-runtime/releases/download/22.37.24175/intel-level-zero-gpu-dbgsym_1.3.24175_amd64.ddeb
wget https://github.com/intel/compute-runtime/releases/download/22.37.24175/intel-level-zero-gpu_1.3.24175_amd64.deb
wget https://github.com/intel/compute-runtime/releases/download/22.37.24175/intel-opencl-icd-dbgsym_22.37.24175_amd64.ddeb
wget https://github.com/intel/compute-runtime/releases/download/22.37.24175/intel-opencl-icd_22.37.24175_amd64.deb
wget https://github.com/intel/compute-runtime/releases/download/22.37.24175/libigdgmm12_22.1.8_amd64.deb
wget https://github.com/intel/compute-runtime/releases/download/22.37.24175/ww37.sum
sha256sum -c ww37.sum
sudo dpkg -i *.deb
```

#### Install Docker
```
sudo apt-get update
sudo apt-get remove docker docker-engine docker.io
sudo apt install -y docker.io
docker --version
```

#### *[Optional] Install systemctl and systemd for WSL2*
```
cd ~
git clone https://github.com/DamionGans/ubuntu-wsl2-systemd-script.git
cd ubuntu-wsl2-systemd-script
bash ubuntu-wsl2-systemd-script.sh --force
```

#### *[Optional] Restart WSL2 Ubuntu CLI then to check systemctl*
```
ps aux
```

#### Start Docker Daemon
```
systemctl start docker
ps aux | grep docker
```

#### Pull image from docker hub and setup container
```
docker login
docker pull brucerry/ubt22.04
docker images
docker run -it --name ubt22.04 -v /home/bruce/share:/home/build/share brucerry/ubt22.04
```

#### Stop container
```
docker stop ubt22.04
docker ps -a
```

#### Start container
```
docker start ubt22.04
docker exec -it ubt22.04 bash
```

#### Stop Docker Daemon
```
# systemctl stop docker
systemctl stop docker.socket
ps aux | grep docker
```

---

## Attach to Running Container in VS Code

1.  Install **WSL** extensions in VS Code
2.  Connect to WSL in VS Code with 2 methods:
    * Run `wsl` and input `code .` in Windows terminal / PowerShell to open VS Code as WSL environment
    * In VS Code, click the left bottom button and select `Connect to WSL`
3.  In VS Code WSL, install **Dev Containers** and **Docker** extensions
4.  Start the container with 2 methods:
    * Right click **start** in the **Docker** extension UI
    * Run commands from the above section
5.  Ensure that the target container has been started
6.  In VS Code WSL, click the left bottom button and select `Attach to Running Container...`
7.  A new VS Code window being popped as the container environment
8.  You now have a window for WSL and another window for the container

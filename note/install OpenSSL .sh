###########
#   auto  #
###########

sudo apt update -y
sudo apt install openssl -y

###########
#  manual #
###########

# Step 1 - Install Dependencies

sudo apt update -y
sudo apt install build-essential checkinstall zlib1g-dev -y

# Step 2 - Download OpenSSL

cd /usr/local/src/
wget https://www.openssl.org/source/openssl-3.0.7.tar.gz
tar -xf openssl-3.0.7.tar.gz
cd openssl-3.0.7

# Step 3 - Install OpenSSL

# 3.1 - Install and Compile OpenSSL

openssl version -a

cd /usr/local/src/openssl-3.0.7
./config --prefix=/usr/local/ssl --openssldir=/usr/local/ssl shared zlib
# --prefix and --openssldir = Set the output path of the OpenSSL.
# shared = force to create a shared library.
# zlib = enable the compression using zlib library.
make
make test
make install

# 3.2 - Configure Link Libraries

cd /etc/ld.so.conf.d/
vim openssl-3.0.7.conf
# add line -> /usr/local/ssl/lib64 for 64-bit system; or
# add line -> /usr/local/ssl/lib for 32-bit system
# save file
sudo ldconfig -v

# 3.3 - Configure OpenSSL Binary

mv /usr/bin/c_rehash /usr/bin/c_rehash.bak
mv /usr/bin/openssl /usr/bin/openssl.bak
export PATH=/usr/local/ssl/bin:$PATH
which openssl

# Step 4 - Testing

openssl version -a

# Install guideline: https://www.howtoforge.com/tutorial/how-to-install-openssl-from-source-on-linux/
# Add path guideline: https://www.baeldung.com/linux/path-variable
# OpenSSL old releases: https://www.openssl.org/source/old/

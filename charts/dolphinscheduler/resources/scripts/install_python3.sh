#!/usr/bin/env bash

# ref: https://github.com/docker-library/python/blob/7b9d62e229/3.10/buster/Dockerfile
set -eux

# runtime dependencies
apt-get update
apt-get install -y --no-install-recommends libbluetooth-dev tk-dev uuid-dev build-essential
rm -rf /var/lib/apt/lists/*


PYTHON_VERSION=3.10.6
INSTALL_PATH=/opt/soft/Python-$PYTHON_VERSION
# configurate install path directory
rm -rf ${INSTALL_PATH} && mkdir -p ${INSTALL_PATH}

# download the python source file
cd /tmp
curl -sL -o python.tar.xz "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz"
mkdir -p /usr/src/python
tar --extract --directory /usr/src/python --strip-components=1 --file python.tar.xz
rm python.tar.xz

# compile python source file
cd /usr/src/python
gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)"
./configure \
  --prefix=${INSTALL_PATH} \
  --build="$gnuArch" \
  --enable-loadable-sqlite-extensions \
  --enable-optimizations \
  --enable-option-checking=fatal \
  --enable-shared \
  --with-lto \
  --with-system-expat \
  --without-ensurepip \
  ;
nproc="$(nproc)"
make -j "$nproc" \
  ;
make install
cd /
rm -rf /usr/src/python

## enable GDB to load debugging data: https://github.com/docker-library/python/pull/701
#bin="$(readlink -ve ${INSTALL_PATH}/bin/python3)"
#dir="$(dirname "$bin")"
#mkdir -p "/usr/share/gdb/auto-load/$dir"
#cp -vL Tools/gdb/libpython.py "/usr/share/gdb/auto-load/$bin-gdb.py"


find ${INSTALL_PATH} -depth \
  \( \
  \( -type d -a \( -name test -o -name tests -o -name idle_test \) \) \
  -o \( -type f -a \( -name '*.pyc' -o -name '*.pyo' -o -name 'libpython*.a' \) \) \
  \) -exec rm -rf '{}' + \
  ;

ln -s /opt/soft/Python-3.10.6 /opt/soft/python
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH:-/opt/soft/python/lib}

${INSTALL_PATH}/bin/python3 --version

# make it work on you environment file
#export PYTHON_HOME=/opt/soft/python
#export PATH=$PYTHON_HOME/bin:$PATH
#ldconfig $PYTHON_HOME/lib
#!/bin/bash
VERSION=9.2.0

mkdir -p src
cd src
wget -c https://mirrors.ocf.berkeley.edu/gnu/octave/octave-${VERSION}.tar.gz
tar zxf octave-${VERSION}.tar.gz
cd octave-${VERSION}

sudo apt-get install -y gfortran libfftw3-dev libfltk1.3-dev libarpack2-dev libqrupdate-dev libreadline-dev libpcre2-dev

./configure --prefix=/opt/octave --without-java 
make

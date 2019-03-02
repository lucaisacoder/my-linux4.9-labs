#!/bin/bash 
# fileName: compile.sh 
# Date: Sun 17 Jun 2018 05:12:05 PM CST 
# Author: light 
# link arm-gcc 
[ ! -f /usr/bin/arm-linux-gnueabi-gcc ] && ln -s /usr/bin/arm-linux-gnueabi-gcc-5 /usr/bin/arm-linux-gnueabi-gcc 

# compile busybox 
cd ./busybox-1.20.2/ 
[ ! -f include/.libbb.h ] && cp include/libbb.h include/.libbb.h 
sed '43i #include<sys/resource.h>' include/.libbb.h > include/libbb.h # why? 请参考我的文章 交叉编译busybox 

make defconfig 
make CROSS_COMPILE=arm-linux-gnueabi- -j4
make install CROSS_COMPILE=arm-linux-gnueabi- 

cd ..

# compile kernel 
cd ./linux-4.9/ 
make CROSS_COMPILE=arm-linux-gnueabi- ARCH=arm vexpress_defconfig -j4
make CROSS_COMPILE=arm-linux-gnueabi- ARCH=arm -j4

cd ..

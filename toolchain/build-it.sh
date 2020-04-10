#!/bin/bash
set -e # Exit on any error

DIR="$( builtin cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TARGET=i386-elf
PREFIX="$DIR/local"
NPROC=${1:-$(nproc)} # First argument or maximum number of cores

mkdir -p "$DIR/tarballs"

pushd "$DIR/tarballs"
	if [ ! -e "binutils-2.34.tar.gz" ]; then
		wget "http://ftp.gnu.org/gnu/binutils/binutils-2.34.tar.gz"
	fi

	if [ ! -e "gcc-9.3.0.tar.gz" ]; then
		wget "http://ftp.gnu.org/gnu/gcc/gcc-9.3.0/gcc-9.3.0.tar.gz"
	fi

	if [ ! -d "binutils-2.34" ]; then
		tar -xf "binutils-2.34.tar.gz"
	fi

	if [ ! -d "gcc-9.3.0" ]; then
		tar -xf "gcc-9.3.0.tar.gz"
	fi
popd

mkdir -p $PREFIX
mkdir -p "$DIR/build/binutils"
mkdir -p "$DIR/build/gcc"

pushd "$DIR/build/"
	pushd binutils
		$DIR/tarballs/binutils-2.34/configure \
			--target=$TARGET \
			--prefix=$PREFIX \
			--enable-interwork \
			--enable-multilib \
			--disable-nls \
			--disable-werror
		make -j $NPROC
		make install
	popd

	pushd gcc
		$DIR/tarballs/gcc-9.3.0/configure \
			--target=$TARGET \
			--prefix=$PREFIX \
			--disable-nls \
			--disable-libssp \
			--enable-languages=c,c++ \
			--without-headers
		make -j $NPROC all-gcc all-target-libgcc
		make install-gcc install-target-libgcc
	popd
popd

echo ""
echo "RogOS toolchain built successfully!"
echo "-----------------------------------"
echo "Append this to your .bashrc:"
echo "export PATH=\"\$PATH:$PREFIX/bin\""
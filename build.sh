#!/bin/bash


export FFMPEG_MAKEING='/data/ffmpeg'
export BIN_FOLDER='/data/ffmpeg/bin'
export BUILD_FOLDER='/data/ffmpeg/build'


yum groupinstall 'Development Tools' && \
 \
cd $FFMPEG_MAKEING && \
git clone --depth 1 git://github.com/yasm/yasm.git && \
cd yasm && \
autoreconf -fiv && \
./configure --prefix="$BUILD_FOLDER" --bindir="$BIN_FOLDER" && \
make && make install && \
 \
cd $FFMPEG_MAKEING && \
git clone --depth 1 git://git.videolan.org/x264 && \
cd x264 && \
export PK G_CONFIG_PATH="$BUILD_FOLDER/lib/pkgconfig" && \
./configure --prefix="$BUILD_FOLDER" --bindir="$BIN_FOLDER" --enable-static && \
make && make install && \
 \
cd $FFMPEG_MAKEING && \
hg clone https://bitbucket.org/multicoreware/x265 && \
cd $FFMPEG_MAKEING/x265/build/linux && \
cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$BUILD_FOLDER" -DENABLE_SHARED:bool=off ../../source && \
make && make install && \
 \
cd $FFMPEG_MAKEING && \
git clone --depth 1 git://git.code.sf.net/p/opencore-amr/fdk-aac && \
cd fdk-aac && \
autoreconf -fiv && \
./configure --prefix="$BUILD_FOLDER" --disable-shared && \
make && make install && \
 \
cd $FFMPEG_MAKEING && \
curl -L -O http://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz && \
tar xzvf lame-3.99.5.tar.gz && \
cd lame-3.99.5 && \
./configure --prefix="$BUILD_FOLDER" --bindir="$BIN_FOLDER" --disable-shared --enable-nasm && \
make && make install && \
 \
cd $FFMPEG_MAKEING && \
git clone http://git.opus-codec.org/opus.git && \
cd opus && \
autoreconf -fiv && \
export PKG_CONFIG_PATH="$BUILD_FOLDER/lib/pkgconfig" && \
./configure --prefix="$BUILD_FOLDER" --disable-shared && \
make && make install && \
 \
cd $FFMPEG_MAKEING && \
git clone --depth 1 https://chromium.googlesource.com/webm/libvpx.git && \
cd libvpx && \
./configure --prefix="$BUILD_FOLDER" --disable-examples && \
make && make install && \
 \
cd $FFMPEG_MAKEING && \
git clone https://git.ffmpeg.org/ffmpeg.git ffmpeg && \
cd ffmpeg && \
PKG_CONFIG_PATH="$BUILD_FOLDER/lib/pkgconfig" && \
./configure --prefix="$BUILD_FOLDER" --extra-cflags="-I$BUILD_FOLDER/include" --extra-ldflags="-L$BUILD_FOLDER/lib -ldl" --bindir="$BIN_FOLDER" --pkg-config-flags="--static" --enable-gpl --enable-nonfree --enable-libfdk-aac --enable-libfreetype --enable-libmp3lame --enable-libopus --enable-libvpx --enable-libx264 --enable-libx265 && \
make && make install && \
 \
echo "" && \
echo "" && \
echo " ____  _____ __  __ _   ___  __  ___ ___   " && \
echo "|  _ \| ____|  \/  | | | \ \/ / |_ _/ _ \  " && \
echo "| |_) |  _| | |\/| | | | |\  /   | | | | | " && \
echo "|  _ <| |___| |  | | |_| |/  \ _ | | |_| | " && \
echo "|_| \_\_____|_|  |_|\___//_/\_(_)___\___/  " && \
echo "| FFMPEG |________________________________ " && \
echo "" && \
echo "FFMPEG make process complete successfully....maybe :)"

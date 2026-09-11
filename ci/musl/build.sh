#!/bin/sh
set -eu
cd /work
mkdir -p logs build prefix dist
exec > logs/build.log 2>&1
apk add --no-cache build-base cmake ninja git binutils zlib-dev xz-dev python3
apk info -v > logs/apk-packages.txt
git config --global --add safe.directory '*'
cp -a /src source
cmake -S source/build/cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=/work/prefix -DCMAKE_INSTALL_LIBDIR=lib \
  -DCMAKE_INSTALL_RPATH='$ORIGIN/../lib' -DBUILD_SHARED_LIBS=ON -DZSTD_BUILD_SHARED=ON -DZSTD_BUILD_STATIC=OFF -DZSTD_BUILD_TESTS=ON -DZSTD_BUILD_PROGRAMS=ON > logs/configure.log 2>&1
cmake --build build --parallel 2 > logs/compile.log 2>&1
ctest --test-dir build --output-on-failure --timeout 600 > logs/tests.log 2>&1
cmake --install build > logs/install.log 2>&1
python /src/ci/musl/package.py

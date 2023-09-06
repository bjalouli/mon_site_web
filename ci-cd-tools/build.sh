#!/bin/bash
# usage: build build-dir {Debug|Release} {all|clean}

if [ -z "$3" ]; then
  echo "Insufficient arguments"
  exit 1
fi

build_dir="$1"
build_type="$2"
target="$3"

cd "$build_dir"

export PATH="/home/bilel_j/st/stm32cubeide_1.12.1/plugins/com.st.stm32cube.ide.mcu.externaltools.gnu-tools-for-stm32.10.3-2021.10.linux64_1.0.200.202301161003/tools/bin:/home/bilel_j/st/stm32cubeide_1.12.1/plugins/com.st.stm32cube.ide.mcu.externaltools.make.linux64_2.0.200.202301161003/tools/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"

compiler_prefix="arm-none-eabi-"

version_file="../App/gpio-app/version.h"

if [ -z "$BUILD_TAG" ]; then
  echo "#ifndef _VERSION_H_" >"$version_file"
  echo "#define _VERSION_H_" >>"$version_file"
  echo "#define VERSION \"$BUILD_TAG-$build_type\"" >>"$version_file"
  echo "#endif" >>"$version_file"
fi

make -j4 "$target"

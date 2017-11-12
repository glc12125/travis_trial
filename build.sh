#!/bin/sh

PROJECT_DIR=`pwd`
BUILD_DIR=$PROJECT_DIR/build


function before_install ()
{
  if [ "$TRAVIS_OS_NAME" == "linux" ]; then
    if [ "$CC" == "clang" ]; then
      sudo ln -s ../../bin/ccache /usr/lib/ccache/clang
      sudo ln -s ../../bin/ccache /usr/lib/ccache/clang++
    fi
  fi
}

function build_lib_core()
{
  echo "Configuring and building main ..."
  if [ ! -d $BUILD_DIR ]; then
  	mkdir -p $BUILD_DIR;
  fi
  cd $BUILD_DIR
  cmake -DCMAKE_C_FLAGS="$CMAKE_C_FLAGS" -DCMAKE_CXX_FLAGS="$CMAKE_CXX_FLAGS" \
  		-DCMAKE_BUILD_TYPE=Release \
        $PROJECT_DIR
  # Build
  make -j2
}

case $1 in
  before-install ) before_install;;
  build ) build_lib_core;;
#  build-tests ) build_tests;;
esac
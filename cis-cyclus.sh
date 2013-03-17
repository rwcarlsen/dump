#!/bin/bash

# get absolute path
WD=`echo $(pwd)/$line`

ROOT=$WD/cyclus-full
SRC=$ROOT/src
INSTALL=$ROOT/install
URL=http://github.com/cyclus

mkdir $ROOT
mkdir $SRC
mkdir $INSTALL

INSTALL_CMD="cmake ../src -DCMAKE_INSTALL_PREFIX=$INSTALL"

# get and build cyclopts
REPO=cyclopts
cd $SRC
git clone $URL/$REPO
cd $REPO
mkdir build && cd build
$INSTALL_CMD
make && make install

# get and build cyclus
REPO=cyclus
cd $SRC
git clone $URL/$REPO
cd $REPO
mkdir build && cd build
$INSTALL_CMD -DCYCLOPTS_ROOT_DIR=$INSTALL
make && make install

# test the installation
echo "Running cyclus tests:"
OUTPUT=`$INSTALL/cyclus/bin/CyclusUnitTestDriver`

if [[ `echo $OUTPUT | grep FAILED` ]]; then
  echo "failed" >2
fi


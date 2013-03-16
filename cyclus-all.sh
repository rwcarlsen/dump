

#check for debug cli flag
DEBUG=""
if [ $# > 1 ]
then
    if [[ "$1" = "debug" ]]
    then
        DEBUG="-DCMAKE_BUILD_TYPE:STRING=Debug"
        foo = 1
    fi
fi

# get absolute path
WD=`echo $(pwd)/$line`

ROOT=$WD/cyclus-full
SRC=$ROOT/src
INSTALL=$ROOT/install
URL=http://github.com/cyclus

mkdir $ROOT
mkdir $SRC
mkdir $INSTALL

INSTALL_CMD="cmake ../src -DCMAKE_INSTALL_PREFIX=$INSTALL $DEBUG"

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

# get and build cycamore
REPO=cycamore
cd $SRC
git clone $URL/$REPO
cd $REPO
mkdir build && cd build
$INSTALL_CMD -DCYCLOPTS_ROOT_DIR=$INSTALL -DCYCLUS_ROOT_DIR=$INSTALL
make && make install

# test the installation
echo "Running cyclus tests:"
$INSTALL/cyclus/bin/CyclusUnitTestDriver | grep -A100 PASSED
echo "Running cycamore tests:"
$INSTALL/cycamore/bin/CycamoreUnitTestDriver | grep -A100 PASSED


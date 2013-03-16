
# get absolute path
WD=`echo $(pwd)/$line`

ROOT=$WD/cyclus-root
SRC=$ROOT/src
INSTALL=$ROOT/install

mkdir $ROOT
mkdir $SRC
mkdir $INSTALL

# get and build cyclopts
cd $SRC
git clone http://github.com/cyclus/cyclopts
cd cyclopts
mkdir build && cd build
cmake ../src -DCMAKE_INSTALL_PREFIX=$INSTALL
make && make install

# cleanup
rm -rf build

git clone http://github.com/cyclus/cyclus
cd cyclus
mkdir build && cd build
cmake ../src -DCMAKE_INSTALL_PREFIX=$INSTALL -DCYCLOPTS_ROOT_DIR=$INSTALL
make && make install


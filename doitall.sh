#!/bin/bash
echo "1. Copying uploaded files (in $(pwd))"
if [[ ! -f upload_here/goblint ]] ; then
    echo "upload_here/goblint does not exist!"
    exit 1
fi
for f in upload_here/goblint*; do cp -f $f goblint-package/usr/bin/$(basename $f).exe; done
echo "2. create_package.sh (in $(pwd))"
cd goblint-package && ./create_package.sh && cd ..
echo "3. update.sh (in $(pwd))"
./update.sh
echo "4. cp setup.ini, genini (in $(pwd))"
cp -f cygwin/x86/setup.ini setup
./gobwin/genini --recursive --okmissing=source gobwin | tail -n +6 | sed 's/gobwin/x86/' >> setup
# 32bit binaries do not run using cygwin64!
# cp -f cygwin/x86_64/setup.ini setup64
# ./gobwin/genini --recursive --okmissing=source gobwin | tail -n +6 | sed 's/gobwin/x86_64/' >> setup64
echo "5. setup -> setup.bz2 (in $(pwd))"
bzip2 -vf setup
# bzip2 -vf setup64
mv -f setup.bz2 cygwin/x86
# mv -f setup64.bz2 cygwin/x86_64/setup.bz2
echo "6. Delete uploaded files (in $(pwd))"
rm -f upload_here/goblint*

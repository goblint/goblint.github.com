#!/bin/bash
# rm release/*
rm -rf cygwin/x86/release/{goblint,frama-c}
rsync -vaz --exclude='cygwin/cygwin' --exclude='cygwin/64bit' \
	--exclude='*mail-archives*' --exclude='*src.tar.bz2' \
	--delete --delete-excluded --delete-after \
	--progress \
	rsync://ftp.hawo.stw.uni-erlangen.de/cygwin/ cygwin
# cd release
# ln -s ../cygwin/release/* .
# ln -s ../gobwin/release/* .
# ln -s gobwin/release/* cygwin/x86/release
cp -rf gobwin/release/* cygwin/x86/release
cp -rf gobwin/release/* cygwin/x86_64/release

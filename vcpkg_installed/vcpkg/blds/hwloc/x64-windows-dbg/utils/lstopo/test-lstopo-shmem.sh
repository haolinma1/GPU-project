#!/bin/sh
#-*-sh-*-

# Copyright © 2009-2020 Inria.  All rights reserved.
# See COPYING in top-level directory.
#

HWLOC_top_builddir="/d/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/hwloc/x64-windows-dbg"
builddir="$HWLOC_top_builddir/utils/lstopo"
ls="$builddir/lstopo-no-graphics"

HWLOC_PLUGINS_PATH=${HWLOC_top_builddir}/hwloc/.libs
export HWLOC_PLUGINS_PATH

HWLOC_DEBUG_CHECK=1
export HWLOC_DEBUG_CHECK

: ${TMPDIR=/tmp}
{
  tmp=`
    (umask 077 && mktemp -d "$TMPDIR/fooXXXXXX") 2>/dev/null
  ` &&
  test -n "$tmp" && test -d "$tmp"
} || {
  tmp=$TMPDIR/foo$$-$RANDOM
  (umask 077 && mkdir "$tmp")
} || exit $?
echo "Outputs will be sent to $tmp"

unset DISPLAY

echo "Exporting to $tmp/test.shmem ..."
$ls $tmp/test.shmem > $tmp/test.shmem.out 2> $tmp/test.shmem.err
return=$?
cat $tmp/test.shmem.out $tmp/test.shmem.err
if test $return != 0; then
    if grep "shmem topology not supported" $tmp/test.shmem.err >/dev/null \
       || grep "Failed to find a shmem topology mmap address" $tmp/test.shmem.err >/dev/null \
       || grep "Failed to export shmem topology, memory range is busy" $tmp/test.shmem.err >/dev/null; then
	echo "Expected error during export, skipping this test"
	exit 77
    fi
    echo "Failed"
    exit 1
fi

echo "Importing from $tmp/test.shmem ..."
$ls -i $tmp/test.shmem - > $tmp/test.shmem.out2 2> $tmp/test.shmem.err2
return=$?
cat $tmp/test.shmem.out2 $tmp/test.shmem.err2
if test $return != 0; then
    if grep "Failed to adopt shmem topology, memory range is busy" $tmp/test.shmem.err2 >/dev/null; then
	echo "Expected error during import, skipping this test"
	exit 77
    fi
    echo "Failed"
    exit 1
fi

rm -rf "$tmp"

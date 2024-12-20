#!/bin/sh
#-*-sh-*-

#
# Copyright © 2009-2020 Inria.  All rights reserved.
# Copyright © 2014 Cisco Systems, Inc.  All rights reserved.
# See COPYING in top-level directory.
#

HWLOC_top_srcdir="/d/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/hwloc/src/loc-2.11.2-a8fd08dd1a.clean"
HWLOC_top_builddir="/d/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/hwloc/x64-windows-rel"
srcdir="$HWLOC_top_srcdir/utils/hwloc"
builddir="$HWLOC_top_builddir/utils/hwloc"
diff="$builddir/hwloc-diff"
patch="$builddir/hwloc-patch"

HWLOC_PLUGINS_PATH=${HWLOC_top_builddir}/hwloc/.libs
export HWLOC_PLUGINS_PATH

HWLOC_DEBUG_CHECK=1
export HWLOC_DEBUG_CHECK

HWLOC_XML_EXPORT_SUPPORT=0
export HWLOC_XML_EXPORT_SUPPORT

if test x1 = x1; then
  # make sure we use default numeric formats
  LANG=C
  LC_ALL=C
  export LANG LC_ALL
fi

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

cd "$tmp"
diffoutput="test-hwloc-diffpatch.diff.xml"
output1="test-hwloc-diffpatch.output1"
output2="test-hwloc-diffpatch.output2"

set -e

$diff $srcdir/test-hwloc-diffpatch.input1 \
    $srcdir/test-hwloc-diffpatch.input2 > $diffoutput
cp $srcdir/test-hwloc-diffpatch.input1 .
#cat $diffoutput | $patch $srcdir/test-hwloc-diffpatch.input1 - $output1
cat $diffoutput | $patch refname - $output1
$patch -R $srcdir/test-hwloc-diffpatch.input2 $diffoutput $output2

/usr/bin/diff -u -w $srcdir/test-hwloc-diffpatch.input1 "$output2"
/usr/bin/diff -u -w $srcdir/test-hwloc-diffpatch.input2 "$output1"

cd ..
rm -rf "$tmp"

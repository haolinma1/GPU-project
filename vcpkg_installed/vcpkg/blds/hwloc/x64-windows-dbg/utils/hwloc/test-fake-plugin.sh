#!/bin/sh
#-*-sh-*-

#
# Copyright © 2009-2019 Inria.  All rights reserved.
# Copyright © 2009, 2011 Université Bordeaux
# Copyright © 2014 Cisco Systems, Inc.  All rights reserved.
# See COPYING in top-level directory.
#

HWLOC_top_builddir="/d/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/hwloc/x64-windows-dbg"
builddir="$HWLOC_top_builddir"
lstopo="$builddir/utils/lstopo/lstopo-no-graphics"
hcalc="$builddir/utils/hwloc/hwloc-calc"

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
file="$tmp/test-fake-plugin.output"

set -e

echo "Checking that the tweak phase restricts to a single PU and single NUMA"
HWLOC_DEBUG_FAKE_COMPONENT_TWEAK=1
export HWLOC_DEBUG_FAKE_COMPONENT_TWEAK

test `$hcalc -N pu root` = 1
test `$hcalc -N numa root` = 1

echo "Checking that the init/instantiate/finalize callbacks are invoked"
HWLOC_DEBUG_FAKE_COMPONENT=1
export HWLOC_DEBUG_FAKE_COMPONENT

$lstopo > $file

grep "fake component initialized" $file || false
grep "fake component instantiated" $file || false
grep "fake component finalized" $file || false

rm -rf "$tmp"

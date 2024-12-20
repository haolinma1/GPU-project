#!/bin/sh
#-*-sh-*-

#
# Copyright © 2009 CNRS
# Copyright © 2009-2024 Inria.  All rights reserved.
# Copyright © 2009 Université Bordeaux
# Copyright © 2014 Cisco Systems, Inc.  All rights reserved.
# See COPYING in top-level directory.
#

HWLOC_top_srcdir="/d/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/hwloc/src/loc-2.11.2-a8fd08dd1a.clean"
HWLOC_top_builddir="/d/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/hwloc/x64-windows-rel"
srcdir="$HWLOC_top_srcdir/utils/hwloc"
builddir="$HWLOC_top_builddir/utils/hwloc"
distrib="$builddir/hwloc-distrib"

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
file="$tmp/test-hwloc-distrib.output"

set -e
(
  echo "# 2 sets out of 2 2 2"
  $distrib --if synthetic --input "2 2 2" 2
  echo
  echo "# 4 sets out of 2 2 2, as lists"
  $distrib --if synthetic --input "2 2 2" --cof list 4
  echo
  echo "# 8 sets out of 2 2 2"
  $distrib --if synthetic --input "2 2 2" 8
  echo
  echo "# 13 sets out of 2 2 2"
  $distrib --if synthetic --input "2 2 2" 13
  echo
  echo "# 16 sets out of 2 2 2"
  $distrib --if synthetic --input "2 2 2" 16
  echo

  echo "# 4 sets out of 3 3 3"
  $distrib --if synthetic --input "3 3 3" 4
  echo
  echo "# 4 singlified sets out of 3 3 3"
  $distrib --if synthetic --input "3 3 3" 4 --single
  echo
  echo "# 4 sets out of 3 3 3, reversed"
  $distrib --if synthetic --input "3 3 3" 4 --reverse
  echo
  echo "# 4 singlified sets out of 3 3 3, reversed"
  $distrib --if synthetic --input "3 3 3" 4 --reverse --single
  echo

  echo "# 2 sets out of 4 4"
  $distrib --if synthetic --input "4 4" 2
  echo
  echo "# 2 singlified sets out of 4 4"
  $distrib --if synthetic --input "4 4" 2 --single
  echo
  echo "# 2 singlified sets out of 4 4, reversed"
  $distrib --if synthetic --input "4 4" 2 --reverse --single
  echo
  echo "# 19 sets out of 4 4"
  $distrib --if synthetic --input "4 4 4 4" 19
  echo

  echo "# 9 sets out of 2 2 2 2"
  $distrib --if synthetic --input "2 2 2 2" 9
  echo
  echo "# 9 sets out of 2 2 2 2, starting at PU level"
  $distrib --if synthetic --input "2 2 2 2" --from pu 9
  echo
  echo "# 9 sets out of 2 2 2 2, stopping at Core level"
  $distrib --if synthetic --input "2 2 2 2" --to core 9
  echo
) > "$file"
/usr/bin/diff -u -w $srcdir/test-hwloc-distrib.output "$file"
rm -rf "$tmp"

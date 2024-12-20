#!/bin/sh
#-*-sh-*-

#
# Copyright © 2009-2022 Inria.  All rights reserved.
# See COPYING in top-level directory.
#

#
# This test builds an asymmetric and heterogeneous topology.
# First package has 4 SMT "Big" cores with 200 GB of DRAM.
# Second package has 8 "Little" cores (no HT) with 100GB of DRAM and 10GB of HBM.
#

HWLOC_top_srcdir="/d/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/hwloc/src/loc-2.11.2-a8fd08dd1a.clean"
HWLOC_top_builddir="/d/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/hwloc/x64-windows-rel"
srcdir="$HWLOC_top_srcdir/utils/hwloc"
builddir="$HWLOC_top_builddir/utils/hwloc"
calc="$builddir/hwloc-calc"
lstopo="$builddir/../lstopo/lstopo-no-graphics"
annotate="$builddir/hwloc-annotate"

HWLOC_DONT_ADD_VERSION_INFO=1
export HWLOC_DONT_ADD_VERSION_INFO

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
file="$tmp/custom-topology.xml"
filetmp="$tmp/custom-topology.tmp.xml"

set -e

echo "creating symmetric topology ..."
$lstopo -i "pack:2 [numa(memory=100GiB)] [numa(memory=10GiB)] core:8 pu:2" --of xml $file

echo "listing PUs to keep ..."
cpuset=`$calc -i $file pack:0.core:0-3.pu:0-1 pack:1.core:0-7.pu:0`

echo "filtering PUs by $cpuset ..."
$lstopo --if xml -i $file --restrict $cpuset --of xml $filetmp
mv -f $filetmp $file

echo "listing NUMAs to keep ..."
nodeset=`$calc -i $file --nodeset node:all ~pack:0.node:1`

echo "filtering NUMAs by $nodeset ..."
$lstopo --if xml -i $file --restrict nodeset=$nodeset --of xml $filetmp
mv -f $filetmp $file

echo "marking cores of first package as more power hungry ..."
$annotate $file $file -- none -- cpukind `$calc -i $file pack:0` 1 0 CoreType Big
$annotate $file $file -- none -- cpukind `$calc -i $file pack:1` 0 0 CoreType Little

echo "marking 1st node of 2nd pack as HBM and others as DRAM ..."
$annotate $file $file -- pack:1.numa:1 -- subtype HBM
$annotate $file $file -- pack:0.numa:0 pack:1.numa:0 -- subtype DRAM

echo "making the first DRAM bigger ..."
$annotate $file $file -- pack:0.numa:0 -- size 200GiB

echo "adding bandwidth for memory nodes ..."
$annotate $file $file -- pack:0.node:0 -- memattr Bandwidth pack:0 50000
$annotate $file $file -- pack:1.node:0 -- memattr Bandwidth pack:1 50000
$annotate $file $file -- pack:1.node:1 -- memattr Bandwidth pack:1 200000

/usr/bin/diff -u -w $srcdir/test-build-custom-topology.output "$file"
rm -rf "$tmp"

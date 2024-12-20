#!/bin/sh
#-*-sh-*-

#
# Copyright © 2009 CNRS
# Copyright © 2009-2024 Inria.  All rights reserved.
# Copyright © 2009, 2011 Université Bordeaux
# Copyright © 2020 Hewlett Packard Enterprise.  All rights reserved.
# See COPYING in top-level directory.
#

HWLOC_top_srcdir="/d/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/hwloc/src/loc-2.11.2-a8fd08dd1a.clean"
HWLOC_top_builddir="/d/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/hwloc/x64-windows-dbg"
srcdir="$HWLOC_top_srcdir/utils/lstopo"
builddir="$HWLOC_top_builddir/utils/lstopo"
ls="$builddir/lstopo-no-graphics"

HWLOC_PLUGINS_PATH=${HWLOC_top_builddir}/hwloc/.libs
export HWLOC_PLUGINS_PATH

HWLOC_DEBUG_CHECK=1
export HWLOC_DEBUG_CHECK

HWLOC_DONT_ADD_VERSION_INFO=1
export HWLOC_DONT_ADD_VERSION_INFO

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

set -e

echo "**** Export once here to see what the platform looks like:"
$ls -

echo "**** Check that we don't crash for the local topology (we can't check the exact output):"
echo "** Textual output in $tmp/test.console ..."
$ls - > $tmp/test.console
echo "** Verbose in $tmp/test.console_verbose ..."
$ls -v > $tmp/test.console_verbose
echo "** Verbose with cpusets in $tmp/test.cpuset_verbose ..."
$ls -c -v > $tmp/test.cpuset_verbose
echo "** Verbose with taskset sets in $tmp/test.taskset ..."
$ls --cpuset-output-format taskset -v > $tmp/test.taskset

echo "** Merged topology in $tmp/test.merge ..."
$ls --merge > $tmp/test.merge
echo "** Without any filtering in $tmp/test.filternone ..."
$ls --filter all:none > $tmp/test.filternone
echo "** With everything filtered out in $tmp/test.filterall ..."
$ls --filter all:all > $tmp/test.filterall

echo "** Without I/O in $tmp/test.no-io ..."
$ls --no-io > $tmp/test.no-io
echo "** Without bridges in $tmp/test.no-bridges ..."
$ls --no-bridges > $tmp/test.no-bridges
echo "** With all I/Os in $tmp/test.whole-io ..."
$ls --whole-io > $tmp/test.whole-io
echo "** Verbose with all I/Os in $tmp/test.wholeio_verbose ..."
$ls -v --whole-io > $tmp/test.wholeio_verbose

echo "** With disallowed objects in $tmp/test.disallowed ..."
$ls --disallowed > $tmp/test.disallowed
echo "** With --top in $tmp/test.top ..."
$ls --top > $tmp/test.top

echo "** ASCII output in $tmp/test.ascii ..."
$ls $tmp/test.ascii

echo "** LaTeX Tikzpicture output in $tmp/test.tikz ..."
$ls $tmp/test.tikz
echo "** LaTeX Tikzpicture output in $tmp/test.tex ..."
$ls $tmp/test.tex
if [ -n "$PDFLATEX" ]; then
  echo "** Test validity of the generated LaTeX output from $tmp/test.tikz ..."
  (cd $tmp && $PDFLATEX test.tikz && $PDFLATEX test.tex)
fi

echo "** FIG output in $tmp/test.fig ..."
$ls $tmp/test.fig
echo "** Native SVG output in $tmp/test.nativesvg ..."
$ls $tmp/test.nativesvg
echo "** (Native by default) SVG output in $tmp/test.svg ..."
$ls $tmp/test.svg

echo "** XML output in $tmp/test.xml ..."
$ls $tmp/test.xml
echo "** Minimalistic XML output in $tmp/test.mini.xml ..."
HWLOC_LIBXML_EXPORT=0 $ls $tmp/test.mini.xml
echo "** XMLv1 output in $tmp/test.v1.xml ..."
$ls --export-xml-flags 1 $tmp/test.v1.xml

file="$tmp/test-lstopo.output"
echo "**** Import from synthetic so that we can check some exact outputs in $file ..."
(
  SI="pa:1 no:2 co:1 l2:2 2"
  echo "** Default output..."
  $ls -i "$SI" -
  echo "** OS-index output merged..."
  $ls -i "$SI" - -p --merge
  echo "** Logical-index verbose output..."
  $ls -i "$SI" - -l --verbose --verbose
  echo "** Export to synthetic..."
  $ls -i "$SI" -.synthetic
  echo "** Export to XML after changing disallowed..."
  $ls -i "$SI" -.xml --allow 0x30 --allow nodeset=0x2
  echo "** Restrict flag cpuless..."
  $ls -i "node:4 pu:4" --restrict 0xf0 --restrict-flags cpuless
  echo "** Restrict flag t\$,memless..."
  $ls -i "node:4 pu:4" --restrict 0x3 --restrict-flags t\$,memless
  echo "** Restrict flag none..."
  $ls -i "node:4 pu:4" --restrict 0x3 --restrict-flags none
  echo "** Export synthetic flag extended,attrs,v1..."
  $ls -i "node:4 pu:4" -.synthetic --export-synthetic-flags extended,attrs,v1
  echo "** Export XML flag v1..."
  $ls -i "node:4 pu:4" -.xml --export-xml-flags v1
  echo "** Topology flag disallowed..."
  $ls -i "node:4 pu:4" - --allow 0xf --flags disallowed -v
) > "$file"
/usr/bin/diff -u -w $srcdir/test-lstopo.output "$file"

if which archivemount >/dev/null 2>/dev/null && test x = x1; then
  echo "**** Archivemount'ing a Linux fsroot archive ..."
  file="$tmp/test-lstopo.archivemount.fsroot.output"
  $ls -i $HWLOC_top_srcdir/tests/hwloc/linux/16amd64-8n2c.tar.bz2 -v - | egrep -v "^assuming " > "$file"
  /usr/bin/diff -u -w $HWLOC_top_srcdir/tests/hwloc/linux/16amd64-8n2c.output "$file"
  if test x = x1; then
    echo "**** Archivemount'ing a x86 CPUID archive ..."
    file="$tmp/test-lstopo.archivemount.cpuid.output"
    HWLOC_XML_EXPORT_SUPPORT=0
    export HWLOC_XML_EXPORT_SUPPORT
    $ls -i $HWLOC_top_srcdir/tests/hwloc/x86/Intel-Skylake-2xXeon6140.tar.bz2 --of xml - | sed   -e 's/ gp_index="[0-9]*"//' | egrep -v "^assuming " > "$file"
    /usr/bin/diff -u -w $HWLOC_top_srcdir/tests/hwloc/x86/Intel-Skylake-2xXeon6140.output "$file"
  fi
fi

rm -rf "$tmp"

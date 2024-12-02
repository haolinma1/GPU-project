#!/bin/sh
#-*-sh-*-

#
# Copyright © 2009-2020 Inria.  All rights reserved.
# See COPYING in top-level directory.
#

HWLOC_top_srcdir="/d/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/hwloc/src/loc-2.11.2-a8fd08dd1a.clean"
include="$HWLOC_top_srcdir/include"
misch="$HWLOC_top_srcdir/utils/hwloc/misc.h"

flags_def=`grep -h _FLAG_ ${include}/hwloc.h ${include}/hwloc/*.h | grep '<<' | grep -v HWLOC_DISTRIB_FLAG \
  | grep -v HWLOC_DISC_STATUS_FLAG | grep -v HWLOC_TOPOLOGY_COMPONENTS_FLAG | cut -d= -f1`

IFS=' ' flags=${flags_def}
for flag in $flags
do
  if ! grep -q "HWLOC_UTILS_PARSING_FLAG($flag)" "$misch"; then
    echo "Could not find any implementation for $flag."
    exit 1
  fi
done
exit 0

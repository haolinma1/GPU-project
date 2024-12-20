#!/bin/sh
#-*-sh-*-

#
# Copyright © 2009 CNRS
# Copyright © 2009-2020 Inria.  All rights reserved.
# Copyright © 2009-2011 Université Bordeaux
# Copyright © 2009-2014 Cisco Systems, Inc.  All rights reserved.
# See COPYING in top-level directory.
#

# Check the conformance of `lstopo' for all the Linux sysfs
# hierarchies available here.  Return true on success.

HWLOC_top_srcdir="/d/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/hwloc/src/loc-2.11.2-a8fd08dd1a.clean"
HWLOC_top_builddir="/d/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/hwloc/x64-windows-dbg"
lstopo="$HWLOC_top_builddir/utils/lstopo/lstopo-no-graphics"

HWLOC_PLUGINS_PATH=${HWLOC_top_builddir}/hwloc/.libs
export HWLOC_PLUGINS_PATH

HWLOC_THISSYSTEM=1
export HWLOC_THISSYSTEM

HWLOC_THISSYSTEM_ALLOWED_RESOURCES=1
export HWLOC_THISSYSTEM_ALLOWED_RESOURCES

HWLOC_DONT_ADD_VERSION_INFO=1
export HWLOC_DONT_ADD_VERSION_INFO

HWLOC_XML_EXPORT_SUPPORT=0
export HWLOC_XML_EXPORT_SUPPORT

actual_output="$1"

# make sure we use default numeric formats (only XML outputs are dis-localized when supported)
LANG=C
LC_ALL=C
export LANG LC_ALL

error()
{
    echo $@ 2>&1
}

# test_topology NAME TOPOLOGY-DIR
#
# Test the topology under TOPOLOGY-DIR.  Return true on success.
test_topology ()
{
    local input="$1"
    local dir="$2"
    local expected_output="$3"
    local options="$4"

    local output="`mktemp`"

    export HWLOC_DEBUG_CHECK=1

    opts="-v -"
    [ -r "$options" ] && opts=`cat $options`

    input=$(cat $input)
    inputformat=synthetic

    if ! HWLOC_FSROOT="$dir" "$lstopo" --if $inputformat -i "$input" $opts \
	> "$output"
    then
	result=1
    else
	if [ "$HWLOC_UPDATE_TEST_TOPOLOGY_OUTPUT" != 1 ]
	then
	    /usr/bin/diff -u -w "$expected_output" "$output"
	    result=$?
	else
	    if ! /usr/bin/diff "$expected_output" "$output" >/dev/null
	    then
		cp -f "$output" "$expected_output"
		echo "Updated $expected_output"
	    fi
	    result=0
	fi
    fi

    rm "$output"

    return $result
}

# test_eligible TOPOLOGY-DIR
#
# Return true if the topology under TOPOLOGY-DIR is eligible for
# testing with the current flavor.
test_eligible()
{
    local dir="$1"
    local output="$2"

    [ -d "$dir" -a -f "$output" ]
}


if [ ! -x "$lstopo" ]
then
    error "Could not find executable file \`$lstopo'."
    exit 1
fi

topology="${actual_output%.output}"
if [ "$topology" = "$actual_output" ] ;
then
    error "Input file \`$1' should end with .output"
    exit 1
fi

actual_options="$topology".options

actual_input="$topology".synthetic

# if there's a .source file, use the tarball name it contains instead of $topology
if [ -f "$topology".source ] ; then
    actual_fsroot="$HWLOC_top_srcdir"/tests/hwloc/linux/allowed/`cat "$topology".fsroot.source`
else
    actual_fsroot="$topology".fsroot.tar.bz2
fi

# if there's a .env file, source it
if [ -f "$topology".env ] ; then
    . "$topology".env
fi

result=1

dir="`mktemp -d`"

if ! ( bunzip2 -c "$actual_fsroot" | ( cd "$dir" && tar xf - $tar_options ) )
then
    error "failed to extract topology \`$topology'"
else
    actual_dir="`echo "$dir"/*`"

    if test_eligible "$actual_dir" "$actual_output"
    then
	test_count="`expr $test_count + 1`"

	test_topology "$actual_input" "$actual_dir" "$actual_output" "$actual_options"
	result=$?
    else
	# Skip this test.
	result=77
    fi
fi

rm -rf "$dir"

exit $result

# Makefile.in generated by automake 1.16.5 from Makefile.am.
# contrib/windows/Makefile.  Generated from Makefile.in by configure.

# Copyright (C) 1994-2021 Free Software Foundation, Inc.

# This Makefile.in is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY, to the extent permitted by law; without
# even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE.



# Copyright © 2009-2020 Inria.  All rights reserved.
# See COPYING in top-level directory.
VPATH = ../.././../src/loc-2.11.2-a8fd08dd1a.clean/contrib/windows
am__is_gnu_make = { \
  if test -z '$(MAKELEVEL)'; then \
    false; \
  elif test -n '$(MAKE_HOST)'; then \
    true; \
  elif test -n '$(MAKE_VERSION)' && test -n '$(CURDIR)'; then \
    true; \
  else \
    false; \
  fi; \
}
am__make_running_with_option = \
  case $${target_option-} in \
      ?) ;; \
      *) echo "am__make_running_with_option: internal error: invalid" \
              "target option '$${target_option-}' specified" >&2; \
         exit 1;; \
  esac; \
  has_opt=no; \
  sane_makeflags=$$MAKEFLAGS; \
  if $(am__is_gnu_make); then \
    sane_makeflags=$$MFLAGS; \
  else \
    case $$MAKEFLAGS in \
      *\\[\ \	]*) \
        bs=\\; \
        sane_makeflags=`printf '%s\n' "$$MAKEFLAGS" \
          | sed "s/$$bs$$bs[$$bs $$bs	]*//g"`;; \
    esac; \
  fi; \
  skip_next=no; \
  strip_trailopt () \
  { \
    flg=`printf '%s\n' "$$flg" | sed "s/$$1.*$$//"`; \
  }; \
  for flg in $$sane_makeflags; do \
    test $$skip_next = yes && { skip_next=no; continue; }; \
    case $$flg in \
      *=*|--*) continue;; \
        -*I) strip_trailopt 'I'; skip_next=yes;; \
      -*I?*) strip_trailopt 'I';; \
        -*O) strip_trailopt 'O'; skip_next=yes;; \
      -*O?*) strip_trailopt 'O';; \
        -*l) strip_trailopt 'l'; skip_next=yes;; \
      -*l?*) strip_trailopt 'l';; \
      -[dEDm]) skip_next=yes;; \
      -[JT]) skip_next=yes;; \
    esac; \
    case $$flg in \
      *$$target_option*) has_opt=yes; break;; \
    esac; \
  done; \
  test $$has_opt = yes
am__make_dryrun = (target_option=n; $(am__make_running_with_option))
am__make_keepgoing = (target_option=k; $(am__make_running_with_option))
pkgdatadir = $(datadir)/hwloc
pkgincludedir = $(includedir)/hwloc
pkglibdir = $(libdir)/hwloc
pkglibexecdir = $(libexecdir)/hwloc
am__cd = CDPATH="$${ZSH_VERSION+.}$(PATH_SEPARATOR)" && cd
install_sh_DATA = $(install_sh) -c -m 644
install_sh_PROGRAM = $(install_sh) -c
install_sh_SCRIPT = $(install_sh) -c
INSTALL_HEADER = $(INSTALL_DATA)
transform = $(program_transform_name)
NORMAL_INSTALL = :
PRE_INSTALL = :
POST_INSTALL = :
NORMAL_UNINSTALL = :
PRE_UNINSTALL = :
POST_UNINSTALL = :
build_triplet = x86_64-pc-mingw32
host_triplet = x86_64-pc-mingw32
target_triplet = x86_64-pc-mingw32
subdir = contrib/windows
ACLOCAL_M4 = $(top_srcdir)/aclocal.m4
am__aclocal_m4_deps = $(top_srcdir)/config/hwloc.m4 \
	$(top_srcdir)/config/hwloc_check_attributes.m4 \
	$(top_srcdir)/config/hwloc_check_vendor.m4 \
	$(top_srcdir)/config/hwloc_check_visibility.m4 \
	$(top_srcdir)/config/hwloc_components.m4 \
	$(top_srcdir)/config/hwloc_internal.m4 \
	$(top_srcdir)/config/hwloc_pkg.m4 \
	$(top_srcdir)/config/libtool.m4 \
	$(top_srcdir)/config/ltoptions.m4 \
	$(top_srcdir)/config/ltsugar.m4 \
	$(top_srcdir)/config/ltversion.m4 \
	$(top_srcdir)/config/lt~obsolete.m4 $(top_srcdir)/configure.ac
am__configure_deps = $(am__aclocal_m4_deps) $(CONFIGURE_DEPENDENCIES) \
	$(ACLOCAL_M4)
DIST_COMMON = $(srcdir)/Makefile.am $(am__DIST_COMMON)
mkinstalldirs = $(install_sh) -d
CONFIG_HEADER = $(top_builddir)/include/private/autogen/config.h \
	$(top_builddir)/include/hwloc/autogen/config.h
CONFIG_CLEAN_FILES =
CONFIG_CLEAN_VPATH_FILES =
AM_V_P = $(am__v_P_$(V))
am__v_P_ = $(am__v_P_$(AM_DEFAULT_VERBOSITY))
am__v_P_0 = false
am__v_P_1 = :
AM_V_GEN = $(am__v_GEN_$(V))
am__v_GEN_ = $(am__v_GEN_$(AM_DEFAULT_VERBOSITY))
am__v_GEN_0 = @echo "  GEN     " $@;
am__v_GEN_1 = 
AM_V_at = $(am__v_at_$(V))
am__v_at_ = $(am__v_at_$(AM_DEFAULT_VERBOSITY))
am__v_at_0 = @
am__v_at_1 = 
SOURCES =
DIST_SOURCES =
am__can_run_installinfo = \
  case $$AM_UPDATE_INFO_DIR in \
    n|no|NO) false;; \
    *) (install-info --version) >/dev/null 2>&1;; \
  esac
am__tagged_files = $(HEADERS) $(SOURCES) $(TAGS_FILES) $(LISP)
am__DIST_COMMON = $(srcdir)/Makefile.in README
DISTFILES = $(DIST_COMMON) $(DIST_SOURCES) $(TEXINFOS) $(EXTRA_DIST)
ACLOCAL = ${SHELL} '/d/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/hwloc/src/loc-2.11.2-a8fd08dd1a.clean/config/missing' aclocal-1.16
AMTAR = $${TAR-tar}
AM_DEFAULT_VERBOSITY = 1
AR = ar-lib lib.exe
AS = :
AUTOCONF = ${SHELL} '/d/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/hwloc/src/loc-2.11.2-a8fd08dd1a.clean/config/missing' autoconf
AUTOHEADER = ${SHELL} '/d/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/hwloc/src/loc-2.11.2-a8fd08dd1a.clean/config/missing' autoheader
AUTOMAKE = ${SHELL} '/d/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/hwloc/src/loc-2.11.2-a8fd08dd1a.clean/config/missing' automake-1.16
AWK = gawk
BASH = /bin/sh
BUNZIPP = false
CC = compile cl.exe
CCDEPMODE = depmode=msvc7
CFLAGS =  -Xcompiler -nologo -Xcompiler -utf-8 -Xcompiler -MP -Xcompiler -MDd -Xcompiler -Z7 -Xcompiler -Ob0 -Xcompiler -Od -Xcompiler -RTC1
CONFIGURE_DEPENDENCIES = $(top_srcdir)/VERSION
CPP = compile cl.exe -E
CPPFLAGS =  -DWIN32 -D_WINDOWS -D_DEBUG
CSCOPE = cscope
CTAGS = ctags
CUDA_VERSION = 
CXX = compile cl.exe
CXXCPP = compile cl.exe -E
CXXDEPMODE = depmode=msvc7
CXXFLAGS = -Xcompiler -nologo -Xcompiler -utf-8 -Xcompiler -GR -Xcompiler -EHsc -Xcompiler -MP -Xcompiler -MDd -Xcompiler -Z7 -Xcompiler -Ob0 -Xcompiler -Od -Xcompiler -RTC1
CYGPATH_W = cygpath -w
DEFS = -DHAVE_CONFIG_H
DEPDIR = .deps
DIFF = /usr/bin/diff
DLLTOOL = link.exe -verbose -dll
DOXYGEN = 
DSYMUTIL = 
DUMPBIN = 
ECHO_C = 
ECHO_N = -n
ECHO_T = 
EGREP = /usr/bin/grep -E
EPSTOPDF = 
ETAGS = etags
EXEEXT = .exe
FGREP = /usr/bin/grep -F
FIG2DEV = 
FILECMD = file
GREP = /usr/bin/grep
GS = 
HWLOC_CAIRO_CFLAGS = 
HWLOC_CAIRO_LIBS = 
HWLOC_CFLAGS =  
HWLOC_CPPFLAGS = -I"$(HWLOC_top_builddir)"/include -I"$(HWLOC_top_srcdir)"/include
HWLOC_CUDART_CFLAGS = 
HWLOC_CUDART_CPPFLAGS = 
HWLOC_CUDART_LDFLAGS = 
HWLOC_CUDART_LIBS = 
HWLOC_CUDA_CFLAGS = 
HWLOC_CUDA_CPPFLAGS = 
HWLOC_CUDA_LDFLAGS = 
HWLOC_CUDA_LIBS = 
HWLOC_DARWIN_LDFLAGS = 
HWLOC_DIFF_U = -u
HWLOC_DIFF_W = -w
HWLOC_DL_LIBS = 
HWLOC_EMBEDDED_CFLAGS = 
HWLOC_EMBEDDED_CPPFLAGS = 
HWLOC_EMBEDDED_LDADD = 
HWLOC_EMBEDDED_LDFLAGS = 
HWLOC_EMBEDDED_LIBS = 
HWLOC_GL_LIBS = 
HWLOC_HAVE_LEVELZERO = 0
HWLOC_HAVE_LIBXML2 = 0
HWLOC_HAVE_LINUX = 
HWLOC_HAVE_NVML = 0
HWLOC_HAVE_OPENCL = 0
HWLOC_HAVE_RSMI = 0
HWLOC_HAVE_X86_CPUID = 
HWLOC_IBVERBS_LIBS = 
HWLOC_LDFLAGS = -no-undefined
HWLOC_LEVELZERO_CFLAGS = 
HWLOC_LEVELZERO_LIBS = 
HWLOC_LIBS = -lgdi32 
HWLOC_LIBS_PRIVATE = 
HWLOC_LIBXML2_CFLAGS = 
HWLOC_LIBXML2_LIBS = 
HWLOC_LTDL_LIBS = 
HWLOC_MS_LIB = /c/Program Files/Microsoft Visual Studio/2022/Enterprise/VC/Tools/MSVC/14.42.34433/bin/Hostx64/x64/lib
HWLOC_MS_LIB_ARCH = X64
HWLOC_NUMA_CFLAGS = 
HWLOC_NUMA_LIBS = 
HWLOC_NVML_CPPFLAGS = 
HWLOC_NVML_LDFLAGS = 
HWLOC_NVML_LIBS = 
HWLOC_OPENCL_CPPFLAGS = 
HWLOC_OPENCL_LDFLAGS = 
HWLOC_OPENCL_LIBS = 
HWLOC_PCIACCESS_CFLAGS = 
HWLOC_PCIACCESS_LIBS = 
HWLOC_PLUGINS_DIR = $(libdir)/hwloc
HWLOC_PLUGINS_PATH = $(libdir)/hwloc
HWLOC_PS_LIBS = 
HWLOC_RELEASE_DATE = Unreleased developer copy
HWLOC_REQUIRES = 
HWLOC_RSMI_CPPFLAGS = 
HWLOC_RSMI_LDFLAGS = 
HWLOC_RSMI_LIBS = 
HWLOC_TERMCAP_LIBS = 
HWLOC_VERSION = 2.11.2rc2-git
HWLOC_W3_GENERATOR = 
HWLOC_X11_CPPFLAGS = 
HWLOC_X11_LIBS = 
HWLOC_XML_LOCALIZED = 1
HWLOC_runstatedir = ${localstatedir}/run
HWLOC_top_builddir = /d/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/hwloc/x64-windows-dbg
HWLOC_top_srcdir = /d/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/hwloc/src/loc-2.11.2-a8fd08dd1a.clean
INSTALL = /usr/bin/install -c
INSTALL_DATA = ${INSTALL} -m 644
INSTALL_PROGRAM = ${INSTALL}
INSTALL_SCRIPT = ${INSTALL}
INSTALL_STRIP_PROGRAM = $(install_sh) -c -s
LD = link.exe -verbose
LDFLAGS = -Xlinker -Xlinker -Xlinker -LIBPATH:D:/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/x64-windows/debug/lib -Xlinker -Xlinker -Xlinker -machine:x64 -Xlinker -Xlinker -Xlinker -nologo -Xlinker -Xlinker -Xlinker -debug -Xlinker -Xlinker -Xlinker -INCREMENTAL
LIBOBJS = 
LIBS =  -lkernel32 -luser32 -lgdi32 -lwinspool -lshell32 -lole32 -loleaut32 -lcomdlg32 -ladvapi32
LIBTOOL = $(SHELL) $(top_builddir)/libtool
LIPO = 
LN_S = cp -pR
LTLIBOBJS = 
LT_SYS_LIBRARY_PATH = 
LYNX = 
MAKEINDEX = 
MAKEINFO = ${SHELL} '/d/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/hwloc/src/loc-2.11.2-a8fd08dd1a.clean/config/missing' makeinfo
MANIFEST_TOOL = mt
MKDIR_P = /usr/bin/mkdir -p
NM = dumpbin.exe -symbols -headers
NMEDIT = 
OBJDUMP = objdump
OBJEXT = obj
OTOOL = 
OTOOL64 = 
PACKAGE = hwloc
PACKAGE_BUGREPORT = https://github.com/open-mpi/hwloc/issues
PACKAGE_NAME = hwloc
PACKAGE_STRING = hwloc 2.11.2rc2-git
PACKAGE_TARNAME = hwloc
PACKAGE_URL = 
PACKAGE_VERSION = 2.11.2rc2-git
PATH_SEPARATOR = :
PDFLATEX = 
PKG_CONFIG = C:/Users/10123/AppData/Local/vcpkg/downloads/tools/msys2/1e74ca60daa10104/mingw64/bin/pkg-config.exe
RANLIB = :
ROCM_VERSION = 
SED = /usr/bin/sed
SET_MAKE = 
SHELL = /bin/sh
STRIP = :
VERSION = 2.11.2rc2-git
W3M = 
XMKMF = 
XMLLINT = 
X_CFLAGS = 
X_EXTRA_LIBS = 
X_LIBS = 
X_PRE_LIBS = 
abs_builddir = /d/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/hwloc/x64-windows-dbg/contrib/windows
abs_srcdir = /d/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/hwloc/x64-windows-dbg/./../src/loc-2.11.2-a8fd08dd1a.clean/contrib/windows
abs_top_builddir = /d/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/hwloc/x64-windows-dbg
abs_top_srcdir = /d/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/hwloc/x64-windows-dbg/./../src/loc-2.11.2-a8fd08dd1a.clean
ac_ct_AR = 
ac_ct_CC = compile cl.exe
ac_ct_CXX = 
ac_ct_DUMPBIN = 
am__include = include
am__leading_dot = .
am__quote = 
am__tar = tar --format=ustar -chf - "$$tardir"
am__untar = tar -xf -
bindir = ${prefix}/../tools/hwloc/debug/bin
build = x86_64-pc-mingw32
build_alias = x86_64-pc-mingw32
build_cpu = x86_64
build_os = mingw32
build_vendor = pc
builddir = .
datadir = ${datarootdir}
datarootdir = ${prefix}/share/hwloc
docdir = ${datarootdir}/doc/${PACKAGE_TARNAME}
dvidir = ${docdir}
exec_prefix = ${prefix}
host = x86_64-pc-mingw32
host_alias = 
host_cpu = x86_64
host_os = mingw32
host_vendor = pc
htmldir = ${docdir}
includedir = ${prefix}/../include
infodir = ${datarootdir}/info
install_sh = ${SHELL} /d/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/hwloc/src/loc-2.11.2-a8fd08dd1a.clean/config/install-sh
libdir = ${prefix}/lib
libexecdir = ${exec_prefix}/libexec
libhwloc_so_name = 15
libhwloc_so_version = 23:1:8
libhwloc_so_version_current_minus_age = 
localedir = ${datarootdir}/locale
localstatedir = ${prefix}/var
mandir = ${datarootdir}/man
mkdir_p = $(MKDIR_P)
oldincludedir = /usr/include
pdfdir = ${docdir}
prefix = /D/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/x64-windows/debug
program_transform_name = s,x,x,
psdir = ${docdir}
runstatedir = ${localstatedir}/run
sbindir = ${prefix}/../tools/hwloc/debug/sbin
sharedstatedir = ${prefix}/com
srcdir = ../.././../src/loc-2.11.2-a8fd08dd1a.clean/contrib/windows
sysconfdir = ${prefix}/etc
target = x86_64-pc-mingw32
target_alias = 
target_cpu = x86_64
target_os = mingw32
target_vendor = pc
top_build_prefix = ../../
top_builddir = ../..
top_srcdir = ../.././../src/loc-2.11.2-a8fd08dd1a.clean
EXTRA_DIST = \
	README \
	hwloc.sln \
	hwloc_config.h \
	private_config.h \
	static-components.h \
	libhwloc.vcxproj \
	libhwloc.vcxproj.filters \
	hwloc-annotate.vcxproj \
	hwloc-annotate.vcxproj.filters \
	hwloc-bind.vcxproj \
	hwloc-bind.vcxproj.filters \
	hwloc-calc.vcxproj \
	hwloc-calc.vcxproj.filters \
	hwloc-diff.vcxproj \
	hwloc-diff.vcxproj.filters \
	hwloc-distrib.vcxproj \
	hwloc-distrib.vcxproj.filters \
	hwloc-gather-cpuid.vcxproj \
	hwloc-gather-cpuid.vcxproj.filters \
	hwloc-info.vcxproj \
	hwloc-info.vcxproj.filters \
	hwloc-patch.vcxproj \
	hwloc-patch.vcxproj.filters \
	lstopo-no-graphics.vcxproj \
	lstopo-no-graphics.vcxproj.filters \
	lstopo-win.vcxproj \
	lstopo-win.vcxproj.filters \
	lstopo.vcxproj \
	lstopo.vcxproj.filters \
	app.manifest \
	check-versions.sh

all: all-am

.SUFFIXES:
$(srcdir)/Makefile.in:  $(srcdir)/Makefile.am  $(am__configure_deps)
	@for dep in $?; do \
	  case '$(am__configure_deps)' in \
	    *$$dep*) \
	      ( cd $(top_builddir) && $(MAKE) $(AM_MAKEFLAGS) am--refresh ) \
	        && { if test -f $@; then exit 0; else break; fi; }; \
	      exit 1;; \
	  esac; \
	done; \
	echo ' cd $(top_srcdir) && $(AUTOMAKE) --foreign contrib/windows/Makefile'; \
	$(am__cd) $(top_srcdir) && \
	  $(AUTOMAKE) --foreign contrib/windows/Makefile
Makefile: $(srcdir)/Makefile.in $(top_builddir)/config.status
	@case '$?' in \
	  *config.status*) \
	    cd $(top_builddir) && $(MAKE) $(AM_MAKEFLAGS) am--refresh;; \
	  *) \
	    echo ' cd $(top_builddir) && $(SHELL) ./config.status $(subdir)/$@ $(am__maybe_remake_depfiles)'; \
	    cd $(top_builddir) && $(SHELL) ./config.status $(subdir)/$@ $(am__maybe_remake_depfiles);; \
	esac;

$(top_builddir)/config.status: $(top_srcdir)/configure $(CONFIG_STATUS_DEPENDENCIES)
	cd $(top_builddir) && $(MAKE) $(AM_MAKEFLAGS) am--refresh

$(top_srcdir)/configure:  $(am__configure_deps)
	cd $(top_builddir) && $(MAKE) $(AM_MAKEFLAGS) am--refresh
$(ACLOCAL_M4):  $(am__aclocal_m4_deps)
	cd $(top_builddir) && $(MAKE) $(AM_MAKEFLAGS) am--refresh
$(am__aclocal_m4_deps):

mostlyclean-libtool:
	-rm -f *.lo

clean-libtool:
	-rm -rf .libs _libs
tags TAGS:

ctags CTAGS:

cscope cscopelist:

distdir: $(BUILT_SOURCES)
	$(MAKE) $(AM_MAKEFLAGS) distdir-am

distdir-am: $(DISTFILES)
	@srcdirstrip=`echo "$(srcdir)" | sed 's/[].[^$$\\*]/\\\\&/g'`; \
	topsrcdirstrip=`echo "$(top_srcdir)" | sed 's/[].[^$$\\*]/\\\\&/g'`; \
	list='$(DISTFILES)'; \
	  dist_files=`for file in $$list; do echo $$file; done | \
	  sed -e "s|^$$srcdirstrip/||;t" \
	      -e "s|^$$topsrcdirstrip/|$(top_builddir)/|;t"`; \
	case $$dist_files in \
	  */*) $(MKDIR_P) `echo "$$dist_files" | \
			   sed '/\//!d;s|^|$(distdir)/|;s,/[^/]*$$,,' | \
			   sort -u` ;; \
	esac; \
	for file in $$dist_files; do \
	  if test -f $$file || test -d $$file; then d=.; else d=$(srcdir); fi; \
	  if test -d $$d/$$file; then \
	    dir=`echo "/$$file" | sed -e 's,/[^/]*$$,,'`; \
	    if test -d "$(distdir)/$$file"; then \
	      find "$(distdir)/$$file" -type d ! -perm -700 -exec chmod u+rwx {} \;; \
	    fi; \
	    if test -d $(srcdir)/$$file && test $$d != $(srcdir); then \
	      cp -fpR $(srcdir)/$$file "$(distdir)$$dir" || exit 1; \
	      find "$(distdir)/$$file" -type d ! -perm -700 -exec chmod u+rwx {} \;; \
	    fi; \
	    cp -fpR $$d/$$file "$(distdir)$$dir" || exit 1; \
	  else \
	    test -f "$(distdir)/$$file" \
	    || cp -p $$d/$$file "$(distdir)/$$file" \
	    || exit 1; \
	  fi; \
	done
check-am: all-am
check: check-am
all-am: Makefile
installdirs:
install: install-am
install-exec: install-exec-am
install-data: install-data-am
uninstall: uninstall-am

install-am: all-am
	@$(MAKE) $(AM_MAKEFLAGS) install-exec-am install-data-am

installcheck: installcheck-am
install-strip:
	if test -z '$(STRIP)'; then \
	  $(MAKE) $(AM_MAKEFLAGS) INSTALL_PROGRAM="$(INSTALL_STRIP_PROGRAM)" \
	    install_sh_PROGRAM="$(INSTALL_STRIP_PROGRAM)" INSTALL_STRIP_FLAG=-s \
	      install; \
	else \
	  $(MAKE) $(AM_MAKEFLAGS) INSTALL_PROGRAM="$(INSTALL_STRIP_PROGRAM)" \
	    install_sh_PROGRAM="$(INSTALL_STRIP_PROGRAM)" INSTALL_STRIP_FLAG=-s \
	    "INSTALL_PROGRAM_ENV=STRIPPROG='$(STRIP)'" install; \
	fi
mostlyclean-generic:

clean-generic:

distclean-generic:
	-test -z "$(CONFIG_CLEAN_FILES)" || rm -f $(CONFIG_CLEAN_FILES)
	-test . = "$(srcdir)" || test -z "$(CONFIG_CLEAN_VPATH_FILES)" || rm -f $(CONFIG_CLEAN_VPATH_FILES)

maintainer-clean-generic:
	@echo "This command is intended for maintainers to use"
	@echo "it deletes files that may require special tools to rebuild."
clean: clean-am

clean-am: clean-generic clean-libtool mostlyclean-am

distclean: distclean-am
	-rm -f Makefile
distclean-am: clean-am distclean-generic

dvi: dvi-am

dvi-am:

html: html-am

html-am:

info: info-am

info-am:

install-data-am:

install-dvi: install-dvi-am

install-dvi-am:

install-exec-am:

install-html: install-html-am

install-html-am:

install-info: install-info-am

install-info-am:

install-man:

install-pdf: install-pdf-am

install-pdf-am:

install-ps: install-ps-am

install-ps-am:

installcheck-am:

maintainer-clean: maintainer-clean-am
	-rm -f Makefile
maintainer-clean-am: distclean-am maintainer-clean-generic

mostlyclean: mostlyclean-am

mostlyclean-am: mostlyclean-generic mostlyclean-libtool

pdf: pdf-am

pdf-am:

ps: ps-am

ps-am:

uninstall-am:

.MAKE: install-am install-strip

.PHONY: all all-am check check-am clean clean-generic clean-libtool \
	cscopelist-am ctags-am distclean distclean-generic \
	distclean-libtool distdir dvi dvi-am html html-am info info-am \
	install install-am install-data install-data-am install-dvi \
	install-dvi-am install-exec install-exec-am install-html \
	install-html-am install-info install-info-am install-man \
	install-pdf install-pdf-am install-ps install-ps-am \
	install-strip installcheck installcheck-am installdirs \
	maintainer-clean maintainer-clean-generic mostlyclean \
	mostlyclean-generic mostlyclean-libtool pdf pdf-am ps ps-am \
	tags-am uninstall uninstall-am

.PRECIOUS: Makefile


# Tell versions [3.59,3.63) of GNU make to not export all variables.
# Otherwise a system limit (for SysV at least) may be exceeded.
.NOEXPORT:

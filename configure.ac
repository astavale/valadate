AC_INIT([Valadate],
        [1.0.0],
        [https://github.com/chebizarro/valadate/issues],
        [valadate],
        [https://github.com/chebizarro/valadate])

m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])

AC_PREREQ([2.65])

AC_CONFIG_HEADER([config.h])
AC_CONFIG_SRCDIR([Makefile.am])
AC_CONFIG_AUX_DIR([build])
AC_CONFIG_MACRO_DIR([build/autotools])

AM_INIT_AUTOMAKE([1.11 foreign subdir-objects])

AM_MAINTAINER_MODE([enable])

AM_PROG_AR
AM_PATH_GLIB_2_0
AC_PROG_CC
AM_PROG_CC_C_O
AC_PATH_PROG(VALAC, valac, valac)
AC_SUBST(VALAC)

dnl === OS Check =======================================================

AC_CANONICAL_HOST

case $host_os in
  *mingw*)
    platform_win32=yes
    native_win32=yes
    platform_darwin=no
    platform_linux=no
    ;;
  *darwin*)
    platform_win32=no
    native_win32=no
    platform_darwin=yes
    platform_linux=no
    ;;
  *linux*)
    platform_win32=no
    native_win32=no
    platform_darwin=no
    platform_linux=yes
    ;;
  pw32* | *cygwin*)
    platform_win32=yes
    native_win32=no
    platform_darwin=no
    platform_linux=no
    ;;
  *)
    AC_MSG_ERROR([OS $host_os is currently not supported])
    ;;
esac
AM_CONDITIONAL(PLATFORM_WIN32, test x"$platform_win32" = "xyes")
AM_CONDITIONAL(NATIVE_WIN32, test x"$native_win32" = "xyes")
AM_CONDITIONAL(PLATFORM_DARWIN, test x"$platform_darwin" = "xyes")
AM_CONDITIONAL(PLATFORM_LINUX, test x"$platform_linux" = "xyes")

LT_PREREQ([2.2.6])
LT_INIT([disable-static win32-dll])


# Honor aclocal flags
ACLOCAL="$ACLOCAL $ACLOCAL_FLAGS"

dnl === Valadate =======================================================

VALADATE_LIB_DIR=[${PWD}/libvaladate]
AC_SUBST(VALADATE_LIB_DIR)

pkg_modules="glib-2.0 gobject-2.0 gmodule-2.0 libxml-2.0 json-glib-1.0 libxslt"
AC_SUBST(pkg_modules)
PKG_CHECK_MODULES([VALADATE], [$pkg_modules])

AC_SUBST(VALADATE_CFLAGS)
AC_SUBST(VALADATE_LIBS)

# CLI
pkg_cli_modules="glib-2.0"
AC_SUBST(pkg_cli_modules)
PKG_CHECK_MODULES([VALADATE_CLI], [$pkg_cli_modules])

AC_SUBST(VALADATE_CLI_CFLAGS)
AC_SUBST(VALADATE_CLI_LIBS)

dnl === Valadate Tests =================================================

VALADATE_TESTS_DIR=[${PWD}/tests]
AC_SUBST(VALADATE_TESTS_DIR)

tests_pkg_modules="glib-2.0 gobject-2.0 gmodule-2.0 libxml-2.0 json-glib-1.0"

AC_SUBST(tests_pkg_modules)

PKG_CHECK_MODULES([TESTS], [$tests_pkg_modules])

AC_SUBST(TESTS_CFLAGS)
AC_SUBST(TESTS_VALAFLAGS)
AC_SUBST(TESTS_LIBS)

dnl === Test suite =====================================================

GLIB_TESTS

dnl === Test coverage ==================================================

AC_ARG_ENABLE([gcov],
              [AS_HELP_STRING([--enable-gcov], [Enable gcov])],
              [use_gcov=$enableval],
              [use_gcov=no])

AS_IF([test "x$use_gcov" = "xyes"],
      [
        dnl we need gcc:
        AS_IF([test "$GCC" != "yes"], [AC_MSG_ERROR([GCC is required for --enable-gcov])])

        dnl Check if ccache is being used
        AC_CHECK_PROG(SHTOOL, shtool, shtool)
        AS_CASE([`$SHTOOL path $CC`],
                [*ccache*], [gcc_ccache=yes],
                [gcc_ccache=no])

        if test "$gcc_ccache" = "yes" && (test -z "$CCACHE_DISABLE" || test "$CCACHE_DISABLE" != "1"); then
          AC_MSG_ERROR([ccache must be disabled when --enable-gcov option is used. You can disable ccache by setting environment variable CCACHE_DISABLE=1.])
        fi

        ltp_version_list="1.6 1.7 1.8 1.9 1.10 1.11"
        AC_CHECK_PROG(LTP, lcov, lcov)
        AC_CHECK_PROG(LTP_GENHTML, genhtml, genhtml)

        if test "$LTP"; then
          AC_CACHE_CHECK([for ltp version], valadate_cv_ltp_version,
                         [
                           valadate_cv_ltp_version=invalid
                           ltp_version=`$LTP -v 2>/dev/null | $SED -e 's/^.* //'`
                           for ltp_check_version in $ltp_version_list; do
                             if test "$ltp_version" = "$ltp_check_version"; then
                               valadate_cv_ltp_version="$ltp_check_version (ok)"
                             fi
                           done
                         ])
        else
          ltp_msg="To enable code coverage reporting you must have one of the following LTP versions installed: $ltp_version_list"
          AC_MSG_ERROR([$ltp_msg])
        fi

        case $valadate_cv_ltp_version in
          ""|invalid[)]
          ltp_msg="You must have one of the following versions of LTP: $ltp_version_list (found: $ltp_version)."
          AC_MSG_ERROR([$ltp_msg])
          LTP="exit 0;"
          ;;
        esac

        if test -z "$LTP_GENHTML"; then
          AC_MSG_ERROR([Could not find genhtml from the LTP package])
        fi

        AC_DEFINE(HAVE_GCOV, 1, [Whether you have gcov])

        dnl Remove all optimization flags from CFLAGS
        changequote({,})
        CFLAGS=`echo "$CFLAGS" | $SED -e 's/-O[0-9]*//g'`
        VALADATE_CFLAGS=`echo "$VALADATE_CFLAGS" | $SED -e 's/-O[0-9]*//g'`
        TESTS_CFLAGS=`echo "$TESTS_CFLAGS" | $SED -e 's/-O[0-9]*//g'`
        changequote([,])

        dnl Define the special gcc flags
        VALADATE_GCOV_CFLAGS="-O0 -fprofile-arcs -ftest-coverage"
        VALADATE_GCOV_LDADD="-lgcov"

        AC_SUBST(VALADATE_GCOV_CFLAGS)
        AC_SUBST(VALADATE_GCOV_LDADD)

        VALADATE_CFLAGS="$VALADATE_CFLAGS $VALADATE_GCOV_CFLAGS"
        VALADATE_LIBS="$VALADATE_LIBS $VALADATE_GCOV_LDADD"
        
        TESTS_CFLAGS="$TESTS_CFLAGS $VALADATE_GCOV_CFLAGS"
        TESTS_LIBS="$TESTS_LIBS $VALADATE_GCOV_LDADD"
      ])

AM_CONDITIONAL(ENABLE_GCOV, test "x$use_gcov" = "xyes")

dnl === Docs ===========================================================

# Documentation with Valadoc
AC_ARG_ENABLE([docs],
              AS_HELP_STRING([--enable-docs],[Enable documentation generation]),
        [enable_docs=$enableval], [enable_docs=no])
AM_CONDITIONAL([ENABLE_DOCS], [test x$enable_docs = xyes])

have_valadoc=no
if test x$enable_docs = xyes; then
  # make sure the library is new enough and the program exists
  AC_PATH_PROG([VALADOC], [valadoc], [no])
  if test "x$VALADOC" = "xno";
  then
      AC_MSG_RESULT([valadoc documentation not built because not found])
  else
      have_valadoc="yes"
      AC_SUBST(VALADOC)
      PKG_CHECK_MODULES([GTKDOC], gtk-doc)
      have_gtkdoc=yes
  fi
fi
AM_CONDITIONAL([HAVE_VALADOC], [test x$have_valadoc = xyes])

# Introspection
GOBJECT_INTROSPECTION_CHECK([1.38.0])

dnl === Check for setrlimit ============================================

AC_CHECK_HEADERS([sys/resource.h sys/time.h],
        [have_sys_resource_h=yes; break;])

AM_CONDITIONAL(HAVE_SYS_RESOURCE_H, test "x$have_sys_resource_h" = "xyes")


dnl === Makefiles ======================================================

AC_CONFIG_FILES([
	Makefile
	build/Makefile
	build/autotools/Makefile
	libvaladate/Makefile
	libvaladate/libvaladate-1.0.pc
	libvaladate/valadate-1.0.pc
	tests/Makefile
	tests/genie/Makefile
	tests/libvaladate/Makefile
	tests/libvaladate/data/Makefile
	tests/libvaladate/framework/Makefile
	tests/libvaladate/utils/Makefile
	tests/libvaladate/introspection/Makefile
	tests/PIE/Makefile
	vapi/Makefile
	docs/Makefile
])

AC_OUTPUT

dnl === Summary ========================================================

echo ""
echo " Valadate - $VERSION"
echo ""
echo " • Prefix: ${prefix}"
echo ""
echo " • Compiler flags: ${CFLAGS} ${MAINTAINER_CFLAGS} ${VALADATE_CFLAGS}"
echo ""
echo " • Enable code coverage: ${use_gcov}"
echo ""
echo " • Building on: ${host_os}"
echo ""
echo " • Has sys/resource.h: ${have_sys_resource_h}"
echo ""
echo " • Documentation: ${enable_docs}"
echo ""

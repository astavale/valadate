include $(top_srcdir)/base.am
include $(top_srcdir)/libvaladate/libvaladate.am

lib_LTLIBRARIES = libvaladate-1.0.la libvaladate-cli-1.0.la

# The main valadate library which contains the framework and utilities

libvaladate_1_0_la_SOURCES = \
	$(libvaladate_sources)

libvaladate_1_0_la_CFLAGS = \
	$(VALADATE_CFLAGS)
	
libvaladate_1_0_la_CPPLAGS = \
	-fPIE \
	$(VALADATE_CPPFLAGS)

libvaladate_1_0_la_VALAFLAGS = \
	$(VALADATE_VALAFLAGS) \
	--library libvaladate-1.0 \
	--vapi libvaladate-1.0.vapi \
	-H libvaladate-1.0.h \
	--internal-vapi libvaladate-internal-1.0.vapi \
	-h libvaladate-internal-1.0.h \
	--gir Valadate-1.0.gir

libvaladate_1_0_la_LDFLAGS = \
	-export-dynamic \
	-shared
	
libvaladate_1_0_la_LIBADD = \
	$(VALADATE_LIBS)

# includes
libvaladate_1_0includedir = \
	$(includedir)/libvaladate-1.0

libvaladate_1_0include_HEADERS = \
	libvaladate-1.0.h

# The cli library which bootstraps cl tests

libvaladate_cli_1_0_la_SOURCES = \
	framework/cli-main.vala

libvaladate_cli_1_0_la_CFLAGS = \
	-I$(top_srcdir)/libvaladate \
	$(VALADATE_CLI_CFLAGS)

libvaladate_cli_1_0_la_CPPLAGS = \
	$(VALADATE_CLI_CPPFLAGS)

libvaladate_cli_1_0_la_VALAFLAGS = \
	--pkg libvaladate-1.0 \
	--vapidir $(top_builddir)/libvaladate \
	--vapidir $(top_builddir)/vapi \
	--library valadate-1.0 \
	--vapi valadate-1.0.vapi \
	-H valadate-1.0.h \
	--internal-vapi valadate-internal-1.0.vapi \
	-h valadate-internal-1.0.h \
	$(VALADATE_CLI_VALAFLAGS)

libvaladate_cli_1_0_la_LIBADD = \
	-dlopen	$(VALADATELIB) \
	$(VALADATE_CLI_LIBS)

libvaladate_cli_1_0_la_LDFLAGS = \
	-export-dynamic \
	-shared


# includes
libvaladate_cli_1_0includedir = \
	$(includedir)/valadate-1.0

libvaladate_cli_1_0include_HEADERS = \
	valadate-1.0.h

# Platform specific flags

if PLATFORM_WIN32
libvaladate_1_0_la_LDFLAGS += -no-undefined
libvaladate_cli_1_0_la_LDFLAGS += -no-undefined
endif

if NATIVE_WIN32
libvaladate_1_0_la_LDFLAGS += -export-dynamic
libvaladate_cli_1_0_la_LDFLAGS += -export-dynamic
endif

# vapis
vapidir = \
	$(datadir)/vala/vapi

dist_vapi_DATA = \
	libvaladate-1.0.vapi \
	libvaladate-1.0.deps \
	valadate-1.0.vapi \
	valadate-1.0.deps

# pkg-config
pkgconfigdir = \
	$(libdir)/pkgconfig

pkgconfig_DATA = \
	libvaladate-1.0.pc \
	valadate-1.0.pc


-include $(INTROSPECTION_MAKEFILE)
if HAVE_INTROSPECTION

Valadate-1.0.typelib:
	g-ir-compiler \
		--shared-library=libvaladate.so \
		--output=Valadate-1.0.typelib \
		Valadate-1.0.gir

girdir = $(datadir)/gir-1.0
gir_DATA = Valadate-1.0.gir

typelibdir = $(libdir)/girepository-1.0
typelib_DATA = Valadate-1.0.typelib

CLEANFILES += $(gir_DATA) $(typelib_DATA)
endif


EXTRA_DIST = \
	libvaladate-1.0.pc.in \
	valadate-1.0.pc.in

CLEANFILES += \
	$(libvaladate_1_0_la_SOURCES:.vala=.c) \
	$(libvaladate_cli_1_0_la_SOURCES:.vala=.c) \
	*.vapi \
	*.h \
	*.gir \
	*.pc

DISTCLEANFILES += $(CLEANFILES)

MAINTAINERCLEANFILES = $(DISTCLEANFILES)

.NOTPARALLEL: lib_LTLIBRARIES

-include $(top_srcdir)/git.mk

include $(top_srcdir)/base.am
#include $(top_srcdir)/build/autotools/glib-tap.mk

# --- Test exe ---
#test_programs = testexe-0
noinst_PROGRAMS = testexe-0

testexe_0_SOURCES =  \
	testexe.vala \
	testexetwo.vala
	
testexe_0_VALAFLAGS = \
	$(TESTS_VALAFLAGS) \
	--pkg gmodule-2.0 \
	--gir testexe-0.gir \
	--library Tests

testexe_0_LDADD = \
	$(TESTS_LIBS) \
	$(TEST_RUNNER) \
	-lgio-2.0
	
testexe_0_CPPFLAGS = \
	$(TESTS_CPPFLAGS) \
	-fPIE
	
testexe_0_CFLAGS = \
	$(TESTS_CFLAGS) \
	-pie
	
CLEANFILES += \
	$(testexe_0_SOURCES:.vala=.c) \
	*.vapi \
	*.gir

DISTCLEANFILES += $(CLEANFILES)

-include $(top_srcdir)/git.mk

include $(top_srcdir)/base.am
include $(top_srcdir)/build/autotools/glib-tap.mk

#SUBDIRS = data

test_programs = tests_libvaladate

#log_file = $(VALADATE_TESTS_DIR)/results/ # Where to save the result and output of the test script.
#trs_file = $(VALADATE_TESTS_DIR)/results/ # Where to save the metadata of the test run.


tests_libvaladate_SOURCES =  \
	main.vala \
	testconfigtests.vala \
	textrunnertests.vala \
	testcasetests.vala \
	assertests.vala
	
tests_libvaladate_VALAFLAGS = \
	$(TESTS_VALAFLAGS)

tests_libvaladate_LDADD = \
	$(TESTS_LIBS) \
	$(VALADATELIB)

tests_libvaladate_CPPFLAGS = \
	$(TESTS_CPPFLAGS)
	
tests_libvaladate_CFLAGS = \
	$(TESTS_CFLAGS)

CLEANFILES += \
	$(tests_libvaladate_SOURCES:.vala=.c) \
	*.stamp \
	*.html \
	*.xml \
	*.gcda \
	*.gcno

DISTCLEANFILES += $(CLEANFILES)



-include $(top_srcdir)/git.mk

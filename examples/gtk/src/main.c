/* main.c generated by valac 0.30.0, the Vala compiler
 * generated from main.vala, do not modify */


#include <glib.h>
#include <glib-object.h>
#include <stdlib.h>
#include <string.h>
#include <gtk/gtk.h>
#include <gio/gio.h>


#define EXAMPLE_TYPE_APPLICATION (example_application_get_type ())
#define EXAMPLE_APPLICATION(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EXAMPLE_TYPE_APPLICATION, ExampleApplication))
#define EXAMPLE_APPLICATION_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EXAMPLE_TYPE_APPLICATION, ExampleApplicationClass))
#define EXAMPLE_IS_APPLICATION(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EXAMPLE_TYPE_APPLICATION))
#define EXAMPLE_IS_APPLICATION_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EXAMPLE_TYPE_APPLICATION))
#define EXAMPLE_APPLICATION_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EXAMPLE_TYPE_APPLICATION, ExampleApplicationClass))

typedef struct _ExampleApplication ExampleApplication;
typedef struct _ExampleApplicationClass ExampleApplicationClass;
#define _g_object_unref0(var) ((var == NULL) ? NULL : (var = (g_object_unref (var), NULL)))



gint example_main (gchar** args, int args_length1);
GType example_application_get_type (void) G_GNUC_CONST;
ExampleApplication* example_application_new (void);
ExampleApplication* example_application_construct (GType object_type);


gint example_main (gchar** args, int args_length1) {
	gint result = 0;
	ExampleApplication* application = NULL;
	ExampleApplication* _tmp0_ = NULL;
	gchar** _tmp1_ = NULL;
	gint _tmp1__length1 = 0;
	gint _tmp2_ = 0;
	_tmp0_ = example_application_new ();
	application = _tmp0_;
	_tmp1_ = args;
	_tmp1__length1 = args_length1;
	_tmp2_ = g_application_run ((GApplication*) application, _tmp1__length1, _tmp1_);
	result = _tmp2_;
	_g_object_unref0 (application);
	return result;
}


int main (int argc, char ** argv) {
#if !GLIB_CHECK_VERSION (2,35,0)
	g_type_init ();
#endif
	return example_main (argv, argc);
}



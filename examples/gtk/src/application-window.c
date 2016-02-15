/* application-window.c generated by valac 0.30.0, the Vala compiler
 * generated from application-window.vala, do not modify */


#include <glib.h>
#include <glib-object.h>
#include <gtk/gtk.h>
#include <gio/gio.h>
#include <stdlib.h>
#include <string.h>
#include <pango/pango.h>
#include <gee.h>


#define EXAMPLE_TYPE_APPLICATION_WINDOW (example_application_window_get_type ())
#define EXAMPLE_APPLICATION_WINDOW(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EXAMPLE_TYPE_APPLICATION_WINDOW, ExampleApplicationWindow))
#define EXAMPLE_APPLICATION_WINDOW_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EXAMPLE_TYPE_APPLICATION_WINDOW, ExampleApplicationWindowClass))
#define EXAMPLE_IS_APPLICATION_WINDOW(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EXAMPLE_TYPE_APPLICATION_WINDOW))
#define EXAMPLE_IS_APPLICATION_WINDOW_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EXAMPLE_TYPE_APPLICATION_WINDOW))
#define EXAMPLE_APPLICATION_WINDOW_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EXAMPLE_TYPE_APPLICATION_WINDOW, ExampleApplicationWindowClass))

typedef struct _ExampleApplicationWindow ExampleApplicationWindow;
typedef struct _ExampleApplicationWindowClass ExampleApplicationWindowClass;
typedef struct _ExampleApplicationWindowPrivate ExampleApplicationWindowPrivate;
#define _g_object_unref0(var) ((var == NULL) ? NULL : (var = (g_object_unref (var), NULL)))
#define _g_error_free0(var) ((var == NULL) ? NULL : (var = (g_error_free (var), NULL)))
#define __vala_PangoFontDescription_free0(var) ((var == NULL) ? NULL : (var = (_vala_PangoFontDescription_free (var), NULL)))
#define _g_free0(var) (var = (g_free (var), NULL))
#define _g_list_free0(var) ((var == NULL) ? NULL : (var = (g_list_free (var), NULL)))

struct _ExampleApplicationWindow {
	GtkApplicationWindow parent_instance;
	ExampleApplicationWindowPrivate * priv;
};

struct _ExampleApplicationWindowClass {
	GtkApplicationWindowClass parent_class;
};

struct _ExampleApplicationWindowPrivate {
	GtkStack* stack;
	GtkMenuButton* gears;
	GtkToggleButton* search;
	GtkSearchBar* searchbar;
	GtkSearchEntry* searchentry;
	GtkRevealer* sidebar;
	GtkListBox* words;
	GtkLabel* lines_label;
	GtkLabel* lines;
	GSettings* settings;
};


static gpointer example_application_window_parent_class = NULL;

GType example_application_window_get_type (void) G_GNUC_CONST;
#define EXAMPLE_APPLICATION_WINDOW_GET_PRIVATE(o) (G_TYPE_INSTANCE_GET_PRIVATE ((o), EXAMPLE_TYPE_APPLICATION_WINDOW, ExampleApplicationWindowPrivate))
enum  {
	EXAMPLE_APPLICATION_WINDOW_DUMMY_PROPERTY
};
ExampleApplicationWindow* example_application_window_new (GtkApplication* application);
ExampleApplicationWindow* example_application_window_construct (GType object_type, GtkApplication* application);
static void example_application_window_update_words (ExampleApplicationWindow* self);
static void _example_application_window_update_words_g_object_notify (GObject* _sender, GParamSpec* pspec, gpointer self);
static void example_application_window_update_font (ExampleApplicationWindow* self);
static void _example_application_window_update_font_g_settings_changed (GSettings* _sender, const gchar* key, gpointer self);
void example_application_window_open (ExampleApplicationWindow* self, GFile* file);
static void _vala_PangoFontDescription_free (PangoFontDescription* self);
void example_application_window_update_lines (ExampleApplicationWindow* self);
void example_application_window_visible_child_changed (ExampleApplicationWindow* self);
static void _example_application_window_visible_child_changed_g_object_notify (GObject* _sender, GParamSpec* pspec, gpointer self);
void example_application_window_search_text_changed (ExampleApplicationWindow* self);
static void _example_application_window_search_text_changed_gtk_search_entry_search_changed (GtkSearchEntry* _sender, gpointer self);
static void example_application_window_find_word (ExampleApplicationWindow* self, GtkButton* button);
static void ____lambda4_ (ExampleApplicationWindow* self, GtkButton* b);
static void _____lambda4__gtk_button_clicked (GtkButton* _sender, gpointer self);
static void example_application_window_finalize (GObject* obj);


static void _example_application_window_update_words_g_object_notify (GObject* _sender, GParamSpec* pspec, gpointer self) {
	example_application_window_update_words ((ExampleApplicationWindow*) self);
}


static gpointer _g_object_ref0 (gpointer self) {
	return self ? g_object_ref (self) : NULL;
}


static void _example_application_window_update_font_g_settings_changed (GSettings* _sender, const gchar* key, gpointer self) {
	example_application_window_update_font ((ExampleApplicationWindow*) self);
}


ExampleApplicationWindow* example_application_window_construct (GType object_type, GtkApplication* application) {
	ExampleApplicationWindow * self = NULL;
	GtkApplication* _tmp0_ = NULL;
	GSettings* _tmp1_ = NULL;
	GSettings* _tmp2_ = NULL;
	GtkStack* _tmp3_ = NULL;
	GtkToggleButton* _tmp4_ = NULL;
	GtkSearchBar* _tmp5_ = NULL;
	GSettings* _tmp6_ = NULL;
	GtkRevealer* _tmp7_ = NULL;
	GtkRevealer* _tmp8_ = NULL;
	GtkBuilder* builder = NULL;
	GtkBuilder* _tmp9_ = NULL;
	GMenuModel* menu = NULL;
	GObject* _tmp10_ = NULL;
	GMenuModel* _tmp11_ = NULL;
	GtkMenuButton* _tmp12_ = NULL;
	GAction* action = NULL;
	GSettings* _tmp13_ = NULL;
	GAction* _tmp14_ = NULL;
	GAction* _tmp15_ = NULL;
	GtkLabel* _tmp16_ = NULL;
	GPropertyAction* _tmp17_ = NULL;
	GAction* _tmp18_ = NULL;
	GtkLabel* _tmp19_ = NULL;
	GtkLabel* _tmp20_ = NULL;
	GSettings* _tmp21_ = NULL;
	g_return_val_if_fail (application != NULL, NULL);
	_tmp0_ = application;
	self = (ExampleApplicationWindow*) g_object_new (object_type, "application", _tmp0_, NULL);
	_tmp1_ = g_settings_new ("org.gtk.exampleapp");
	_g_object_unref0 (self->priv->settings);
	self->priv->settings = _tmp1_;
	_tmp2_ = self->priv->settings;
	_tmp3_ = self->priv->stack;
	g_settings_bind (_tmp2_, "transition", (GObject*) _tmp3_, "transition-type", G_SETTINGS_BIND_DEFAULT);
	_tmp4_ = self->priv->search;
	_tmp5_ = self->priv->searchbar;
	g_object_bind_property_with_closures ((GObject*) _tmp4_, "active", (GObject*) _tmp5_, "search-mode-enabled", G_BINDING_BIDIRECTIONAL, (GClosure*) ((NULL == NULL) ? NULL : g_cclosure_new ((GCallback) NULL, NULL, NULL)), (GClosure*) ((NULL == NULL) ? NULL : g_cclosure_new ((GCallback) NULL, NULL, NULL)));
	_tmp6_ = self->priv->settings;
	_tmp7_ = self->priv->sidebar;
	g_settings_bind (_tmp6_, "show-words", (GObject*) _tmp7_, "reveal-child", G_SETTINGS_BIND_DEFAULT);
	_tmp8_ = self->priv->sidebar;
	g_signal_connect_object ((GObject*) _tmp8_, "notify::reveal-child", (GCallback) _example_application_window_update_words_g_object_notify, self, 0);
	_tmp9_ = gtk_builder_new_from_resource ("/org/gtk/exampleapp/gears-menu.ui");
	builder = _tmp9_;
	_tmp10_ = gtk_builder_get_object (builder, "menu");
	_tmp11_ = _g_object_ref0 (G_TYPE_CHECK_INSTANCE_TYPE (_tmp10_, g_menu_model_get_type ()) ? ((GMenuModel*) _tmp10_) : NULL);
	menu = _tmp11_;
	_tmp12_ = self->priv->gears;
	gtk_menu_button_set_menu_model (_tmp12_, menu);
	_tmp13_ = self->priv->settings;
	_tmp14_ = g_settings_create_action (_tmp13_, "show-words");
	action = _tmp14_;
	_tmp15_ = action;
	g_action_map_add_action ((GActionMap*) self, _tmp15_);
	_tmp16_ = self->priv->lines;
	_tmp17_ = g_property_action_new ("show-lines", (GObject*) _tmp16_, "visible");
	_g_object_unref0 (action);
	action = (GAction*) _tmp17_;
	_tmp18_ = action;
	g_action_map_add_action ((GActionMap*) self, _tmp18_);
	_tmp19_ = self->priv->lines;
	_tmp20_ = self->priv->lines_label;
	g_object_bind_property_with_closures ((GObject*) _tmp19_, "visible", (GObject*) _tmp20_, "visible", G_BINDING_DEFAULT, (GClosure*) ((NULL == NULL) ? NULL : g_cclosure_new ((GCallback) NULL, NULL, NULL)), (GClosure*) ((NULL == NULL) ? NULL : g_cclosure_new ((GCallback) NULL, NULL, NULL)));
	_tmp21_ = self->priv->settings;
	g_signal_connect_object (_tmp21_, "changed::font", (GCallback) _example_application_window_update_font_g_settings_changed, self, 0);
	_g_object_unref0 (action);
	_g_object_unref0 (menu);
	_g_object_unref0 (builder);
	return self;
}


ExampleApplicationWindow* example_application_window_new (GtkApplication* application) {
	return example_application_window_construct (EXAMPLE_TYPE_APPLICATION_WINDOW, application);
}


static void _vala_PangoFontDescription_free (PangoFontDescription* self) {
	g_boxed_free (pango_font_description_get_type (), self);
}


void example_application_window_open (ExampleApplicationWindow* self, GFile* file) {
	gchar* basename = NULL;
	GFile* _tmp0_ = NULL;
	gchar* _tmp1_ = NULL;
	gchar* font_name = NULL;
	GSettings* _tmp2_ = NULL;
	gchar* _tmp3_ = NULL;
	PangoFontDescription* font = NULL;
	PangoFontDescription* _tmp4_ = NULL;
	GtkScrolledWindow* scrolled = NULL;
	GtkScrolledWindow* _tmp5_ = NULL;
	GtkTextView* view = NULL;
	GtkTextView* _tmp6_ = NULL;
	GtkStack* _tmp7_ = NULL;
	GtkToggleButton* _tmp18_ = NULL;
	GError * _inner_error_ = NULL;
	g_return_if_fail (self != NULL);
	g_return_if_fail (file != NULL);
	_tmp0_ = file;
	_tmp1_ = g_file_get_basename (_tmp0_);
	basename = _tmp1_;
	_tmp2_ = self->priv->settings;
	_tmp3_ = g_settings_get_string (_tmp2_, "font");
	font_name = _tmp3_;
	_tmp4_ = pango_font_description_from_string (font_name);
	font = _tmp4_;
	_tmp5_ = (GtkScrolledWindow*) gtk_scrolled_window_new (NULL, NULL);
	g_object_ref_sink (_tmp5_);
	scrolled = _tmp5_;
	gtk_widget_show ((GtkWidget*) scrolled);
	gtk_widget_set_hexpand ((GtkWidget*) scrolled, TRUE);
	gtk_widget_set_vexpand ((GtkWidget*) scrolled, TRUE);
	_tmp6_ = (GtkTextView*) gtk_text_view_new ();
	g_object_ref_sink (_tmp6_);
	view = _tmp6_;
	gtk_text_view_set_editable (view, FALSE);
	gtk_text_view_set_cursor_visible (view, FALSE);
	gtk_widget_override_font ((GtkWidget*) view, font);
	gtk_widget_show ((GtkWidget*) view);
	gtk_container_add ((GtkContainer*) scrolled, (GtkWidget*) view);
	_tmp7_ = self->priv->stack;
	gtk_stack_add_titled (_tmp7_, (GtkWidget*) scrolled, basename, basename);
	{
		guint8* contents = NULL;
		gint contents_length1 = 0;
		gint _contents_size_ = 0;
		gboolean _tmp8_ = FALSE;
		GFile* _tmp9_ = NULL;
		guint8* _tmp10_ = NULL;
		gsize _tmp11_;
		gboolean _tmp12_ = FALSE;
		_tmp9_ = file;
		_tmp12_ = g_file_load_contents (_tmp9_, NULL, &_tmp10_, &_tmp11_, NULL, &_inner_error_);
		contents = (g_free (contents), NULL);
		contents = _tmp10_;
		contents_length1 = _tmp11_;
		_contents_size_ = contents_length1;
		_tmp8_ = _tmp12_;
		if (G_UNLIKELY (_inner_error_ != NULL)) {
			contents = (g_free (contents), NULL);
			goto __catch0_g_error;
		}
		if (_tmp8_) {
			GtkTextBuffer* buffer = NULL;
			GtkTextBuffer* _tmp13_ = NULL;
			GtkTextBuffer* _tmp14_ = NULL;
			GtkTextBuffer* _tmp15_ = NULL;
			_tmp13_ = gtk_text_view_get_buffer (view);
			_tmp14_ = _g_object_ref0 (_tmp13_);
			buffer = _tmp14_;
			_tmp15_ = buffer;
			gtk_text_buffer_set_text (_tmp15_, (const gchar*) contents, -1);
			_g_object_unref0 (buffer);
		}
		contents = (g_free (contents), NULL);
	}
	goto __finally0;
	__catch0_g_error:
	{
		GError* e = NULL;
		GError* _tmp16_ = NULL;
		const gchar* _tmp17_ = NULL;
		e = _inner_error_;
		_inner_error_ = NULL;
		_tmp16_ = e;
		_tmp17_ = _tmp16_->message;
		g_warning ("application-window.vala:85: There was an error loading '%s': %s", basename, _tmp17_);
		_g_error_free0 (e);
	}
	__finally0:
	if (G_UNLIKELY (_inner_error_ != NULL)) {
		_g_object_unref0 (view);
		_g_object_unref0 (scrolled);
		__vala_PangoFontDescription_free0 (font);
		_g_free0 (font_name);
		_g_free0 (basename);
		g_critical ("file %s: line %d: uncaught error: %s (%s, %d)", __FILE__, __LINE__, _inner_error_->message, g_quark_to_string (_inner_error_->domain), _inner_error_->code);
		g_clear_error (&_inner_error_);
		return;
	}
	_tmp18_ = self->priv->search;
	gtk_widget_set_sensitive ((GtkWidget*) _tmp18_, TRUE);
	example_application_window_update_words (self);
	example_application_window_update_lines (self);
	_g_object_unref0 (view);
	_g_object_unref0 (scrolled);
	__vala_PangoFontDescription_free0 (font);
	_g_free0 (font_name);
	_g_free0 (basename);
}


void example_application_window_visible_child_changed (ExampleApplicationWindow* self) {
	GtkStack* _tmp0_ = NULL;
	gboolean _tmp1_ = FALSE;
	GtkSearchBar* _tmp2_ = NULL;
	g_return_if_fail (self != NULL);
	_tmp0_ = self->priv->stack;
	_tmp1_ = gtk_widget_in_destruction ((GtkWidget*) _tmp0_);
	if (_tmp1_) {
		return;
	}
	_tmp2_ = self->priv->searchbar;
	gtk_search_bar_set_search_mode (_tmp2_, FALSE);
	example_application_window_update_words (self);
	example_application_window_update_lines (self);
}


static void _example_application_window_visible_child_changed_g_object_notify (GObject* _sender, GParamSpec* pspec, gpointer self) {
	example_application_window_visible_child_changed ((ExampleApplicationWindow*) self);
}


void example_application_window_search_text_changed (ExampleApplicationWindow* self) {
	gchar* text = NULL;
	GtkSearchEntry* _tmp0_ = NULL;
	const gchar* _tmp1_ = NULL;
	gchar* _tmp2_ = NULL;
	const gchar* _tmp3_ = NULL;
	GtkBin* tab = NULL;
	GtkStack* _tmp4_ = NULL;
	GtkWidget* _tmp5_ = NULL;
	GtkBin* _tmp6_ = NULL;
	GtkTextView* view = NULL;
	GtkBin* _tmp7_ = NULL;
	GtkWidget* _tmp8_ = NULL;
	GtkTextView* _tmp9_ = NULL;
	GtkTextBuffer* buffer = NULL;
	GtkTextView* _tmp10_ = NULL;
	GtkTextBuffer* _tmp11_ = NULL;
	GtkTextBuffer* _tmp12_ = NULL;
	GtkTextIter start = {0};
	GtkTextIter match_start = {0};
	GtkTextIter match_end = {0};
	GtkTextBuffer* _tmp13_ = NULL;
	GtkTextIter _tmp14_ = {0};
	const gchar* _tmp15_ = NULL;
	GtkTextIter _tmp16_ = {0};
	GtkTextIter _tmp17_ = {0};
	gboolean _tmp18_ = FALSE;
	g_return_if_fail (self != NULL);
	_tmp0_ = self->priv->searchentry;
	_tmp1_ = gtk_entry_get_text ((GtkEntry*) _tmp0_);
	_tmp2_ = g_strdup (_tmp1_);
	text = _tmp2_;
	_tmp3_ = text;
	if (g_strcmp0 (_tmp3_, "") == 0) {
		_g_free0 (text);
		return;
	}
	_tmp4_ = self->priv->stack;
	_tmp5_ = gtk_stack_get_visible_child (_tmp4_);
	_tmp6_ = _g_object_ref0 (G_TYPE_CHECK_INSTANCE_TYPE (_tmp5_, gtk_bin_get_type ()) ? ((GtkBin*) _tmp5_) : NULL);
	tab = _tmp6_;
	_tmp7_ = tab;
	_tmp8_ = gtk_bin_get_child (_tmp7_);
	_tmp9_ = _g_object_ref0 (G_TYPE_CHECK_INSTANCE_TYPE (_tmp8_, gtk_text_view_get_type ()) ? ((GtkTextView*) _tmp8_) : NULL);
	view = _tmp9_;
	_tmp10_ = view;
	_tmp11_ = gtk_text_view_get_buffer (_tmp10_);
	_tmp12_ = _g_object_ref0 (_tmp11_);
	buffer = _tmp12_;
	_tmp13_ = buffer;
	gtk_text_buffer_get_start_iter (_tmp13_, &_tmp14_);
	start = _tmp14_;
	_tmp15_ = text;
	_tmp18_ = gtk_text_iter_forward_search (&start, _tmp15_, GTK_TEXT_SEARCH_CASE_INSENSITIVE, &_tmp16_, &_tmp17_, NULL);
	match_start = _tmp16_;
	match_end = _tmp17_;
	if (_tmp18_) {
		GtkTextBuffer* _tmp19_ = NULL;
		GtkTextIter _tmp20_ = {0};
		GtkTextIter _tmp21_ = {0};
		GtkTextView* _tmp22_ = NULL;
		GtkTextIter _tmp23_ = {0};
		_tmp19_ = buffer;
		_tmp20_ = match_start;
		_tmp21_ = match_end;
		gtk_text_buffer_select_range (_tmp19_, &_tmp20_, &_tmp21_);
		_tmp22_ = view;
		_tmp23_ = match_start;
		gtk_text_view_scroll_to_iter (_tmp22_, &_tmp23_, 0.0, FALSE, 0.0, 0.0);
	}
	_g_object_unref0 (buffer);
	_g_object_unref0 (view);
	_g_object_unref0 (tab);
	_g_free0 (text);
}


static void _example_application_window_search_text_changed_gtk_search_entry_search_changed (GtkSearchEntry* _sender, gpointer self) {
	example_application_window_search_text_changed ((ExampleApplicationWindow*) self);
}


static void example_application_window_find_word (ExampleApplicationWindow* self, GtkButton* button) {
	gchar* word = NULL;
	GtkButton* _tmp0_ = NULL;
	const gchar* _tmp1_ = NULL;
	gchar* _tmp2_ = NULL;
	GtkSearchEntry* _tmp3_ = NULL;
	g_return_if_fail (self != NULL);
	g_return_if_fail (button != NULL);
	_tmp0_ = button;
	_tmp1_ = gtk_button_get_label (_tmp0_);
	_tmp2_ = g_strdup (_tmp1_);
	word = _tmp2_;
	_tmp3_ = self->priv->searchentry;
	gtk_entry_set_text ((GtkEntry*) _tmp3_, word);
	_g_free0 (word);
}


static void ____lambda4_ (ExampleApplicationWindow* self, GtkButton* b) {
	GtkButton* _tmp0_ = NULL;
	g_return_if_fail (b != NULL);
	_tmp0_ = b;
	example_application_window_find_word (self, _tmp0_);
}


static void _____lambda4__gtk_button_clicked (GtkButton* _sender, gpointer self) {
	____lambda4_ ((ExampleApplicationWindow*) self, _sender);
}


static void example_application_window_update_words (ExampleApplicationWindow* self) {
	GtkBin* tab = NULL;
	GtkStack* _tmp0_ = NULL;
	GtkWidget* _tmp1_ = NULL;
	GtkBin* _tmp2_ = NULL;
	GtkBin* _tmp3_ = NULL;
	GtkTextView* view = NULL;
	GtkBin* _tmp4_ = NULL;
	GtkWidget* _tmp5_ = NULL;
	GtkTextView* _tmp6_ = NULL;
	GtkTextBuffer* buffer = NULL;
	GtkTextView* _tmp7_ = NULL;
	GtkTextBuffer* _tmp8_ = NULL;
	GtkTextBuffer* _tmp9_ = NULL;
	GeeHashMap* strings = NULL;
	GeeHashMap* _tmp10_ = NULL;
	GtkTextIter start = {0};
	GtkTextIter end = {0};
	GtkTextBuffer* _tmp11_ = NULL;
	GtkTextIter _tmp12_ = {0};
	GList* children = NULL;
	GtkListBox* _tmp29_ = NULL;
	GList* _tmp30_ = NULL;
	GList* _tmp31_ = NULL;
	g_return_if_fail (self != NULL);
	_tmp0_ = self->priv->stack;
	_tmp1_ = gtk_stack_get_visible_child (_tmp0_);
	_tmp2_ = _g_object_ref0 (G_TYPE_CHECK_INSTANCE_TYPE (_tmp1_, gtk_bin_get_type ()) ? ((GtkBin*) _tmp1_) : NULL);
	tab = _tmp2_;
	_tmp3_ = tab;
	if (_tmp3_ == NULL) {
		_g_object_unref0 (tab);
		return;
	}
	_tmp4_ = tab;
	_tmp5_ = gtk_bin_get_child (_tmp4_);
	_tmp6_ = _g_object_ref0 (G_TYPE_CHECK_INSTANCE_TYPE (_tmp5_, gtk_text_view_get_type ()) ? ((GtkTextView*) _tmp5_) : NULL);
	view = _tmp6_;
	_tmp7_ = view;
	_tmp8_ = gtk_text_view_get_buffer (_tmp7_);
	_tmp9_ = _g_object_ref0 (_tmp8_);
	buffer = _tmp9_;
	_tmp10_ = gee_hash_map_new (G_TYPE_STRING, (GBoxedCopyFunc) g_strdup, g_free, G_TYPE_STRING, (GBoxedCopyFunc) g_strdup, g_free, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
	strings = _tmp10_;
	_tmp11_ = buffer;
	gtk_text_buffer_get_start_iter (_tmp11_, &_tmp12_);
	start = _tmp12_;
	while (TRUE) {
		gboolean _tmp13_ = FALSE;
		gboolean done = FALSE;
		gboolean _tmp16_ = FALSE;
		GtkTextIter _tmp17_ = {0};
		gboolean _tmp18_ = FALSE;
		gchar* word = NULL;
		GtkTextBuffer* _tmp19_ = NULL;
		GtkTextIter _tmp20_ = {0};
		GtkTextIter _tmp21_ = {0};
		gchar* _tmp22_ = NULL;
		gchar* key = NULL;
		const gchar* _tmp23_ = NULL;
		gchar* _tmp24_ = NULL;
		GeeHashMap* _tmp25_ = NULL;
		const gchar* _tmp26_ = NULL;
		const gchar* _tmp27_ = NULL;
		GtkTextIter _tmp28_ = {0};
		_tmp13_ = gtk_text_iter_is_end (&start);
		if (!(!_tmp13_)) {
			break;
		}
		done = FALSE;
		while (TRUE) {
			gboolean _tmp14_ = FALSE;
			gboolean _tmp15_ = FALSE;
			_tmp14_ = gtk_text_iter_starts_word (&start);
			if (!(!_tmp14_)) {
				break;
			}
			_tmp15_ = gtk_text_iter_forward_char (&start);
			if (!_tmp15_) {
				done = TRUE;
				break;
			}
		}
		_tmp16_ = done;
		if (_tmp16_) {
			break;
		}
		_tmp17_ = start;
		end = _tmp17_;
		_tmp18_ = gtk_text_iter_forward_word_end (&end);
		if (!_tmp18_) {
			break;
		}
		_tmp19_ = buffer;
		_tmp20_ = start;
		_tmp21_ = end;
		_tmp22_ = gtk_text_buffer_get_text (_tmp19_, &_tmp20_, &_tmp21_, FALSE);
		word = _tmp22_;
		_tmp23_ = word;
		_tmp24_ = g_utf8_strdown (_tmp23_, (gssize) -1);
		key = _tmp24_;
		_tmp25_ = strings;
		_tmp26_ = key;
		_tmp27_ = key;
		gee_abstract_map_set ((GeeAbstractMap*) _tmp25_, _tmp26_, _tmp27_);
		_tmp28_ = end;
		start = _tmp28_;
		_g_free0 (key);
		_g_free0 (word);
	}
	_tmp29_ = self->priv->words;
	_tmp30_ = gtk_container_get_children ((GtkContainer*) _tmp29_);
	children = _tmp30_;
	_tmp31_ = children;
	{
		GList* child_collection = NULL;
		GList* child_it = NULL;
		child_collection = _tmp31_;
		for (child_it = child_collection; child_it != NULL; child_it = child_it->next) {
			GtkWidget* child = NULL;
			child = (GtkWidget*) child_it->data;
			{
				GtkListBox* _tmp32_ = NULL;
				GtkWidget* _tmp33_ = NULL;
				_tmp32_ = self->priv->words;
				_tmp33_ = child;
				gtk_container_remove ((GtkContainer*) _tmp32_, _tmp33_);
			}
		}
	}
	{
		GeeIterator* _key_it = NULL;
		GeeHashMap* _tmp34_ = NULL;
		GeeSet* _tmp35_ = NULL;
		GeeSet* _tmp36_ = NULL;
		GeeSet* _tmp37_ = NULL;
		GeeIterator* _tmp38_ = NULL;
		GeeIterator* _tmp39_ = NULL;
		_tmp34_ = strings;
		_tmp35_ = gee_abstract_map_get_keys ((GeeMap*) _tmp34_);
		_tmp36_ = _tmp35_;
		_tmp37_ = _tmp36_;
		_tmp38_ = gee_iterable_iterator ((GeeIterable*) _tmp37_);
		_tmp39_ = _tmp38_;
		_g_object_unref0 (_tmp37_);
		_key_it = _tmp39_;
		while (TRUE) {
			GeeIterator* _tmp40_ = NULL;
			gboolean _tmp41_ = FALSE;
			gchar* key = NULL;
			GeeIterator* _tmp42_ = NULL;
			gpointer _tmp43_ = NULL;
			GtkButton* row = NULL;
			const gchar* _tmp44_ = NULL;
			GtkButton* _tmp45_ = NULL;
			GtkButton* _tmp46_ = NULL;
			GtkButton* _tmp47_ = NULL;
			GtkListBox* _tmp48_ = NULL;
			GtkButton* _tmp49_ = NULL;
			_tmp40_ = _key_it;
			_tmp41_ = gee_iterator_next (_tmp40_);
			if (!_tmp41_) {
				break;
			}
			_tmp42_ = _key_it;
			_tmp43_ = gee_iterator_get (_tmp42_);
			key = (gchar*) _tmp43_;
			_tmp44_ = key;
			_tmp45_ = (GtkButton*) gtk_button_new_with_label (_tmp44_);
			g_object_ref_sink (_tmp45_);
			row = _tmp45_;
			_tmp46_ = row;
			g_signal_connect_object (_tmp46_, "clicked", (GCallback) _____lambda4__gtk_button_clicked, self, 0);
			_tmp47_ = row;
			gtk_widget_show ((GtkWidget*) _tmp47_);
			_tmp48_ = self->priv->words;
			_tmp49_ = row;
			gtk_container_add ((GtkContainer*) _tmp48_, (GtkWidget*) _tmp49_);
			_g_object_unref0 (row);
			_g_free0 (key);
		}
		_g_object_unref0 (_key_it);
	}
	_g_list_free0 (children);
	_g_object_unref0 (strings);
	_g_object_unref0 (buffer);
	_g_object_unref0 (view);
	_g_object_unref0 (tab);
}


void example_application_window_update_lines (ExampleApplicationWindow* self) {
	GtkBin* tab = NULL;
	GtkStack* _tmp0_ = NULL;
	GtkWidget* _tmp1_ = NULL;
	GtkBin* _tmp2_ = NULL;
	GtkBin* _tmp3_ = NULL;
	GtkTextView* view = NULL;
	GtkBin* _tmp4_ = NULL;
	GtkWidget* _tmp5_ = NULL;
	GtkTextView* _tmp6_ = NULL;
	GtkTextBuffer* buffer = NULL;
	GtkTextView* _tmp7_ = NULL;
	GtkTextBuffer* _tmp8_ = NULL;
	GtkTextBuffer* _tmp9_ = NULL;
	gint count = 0;
	GtkTextIter iter = {0};
	GtkTextBuffer* _tmp10_ = NULL;
	GtkTextIter _tmp11_ = {0};
	gchar* lns = NULL;
	gint _tmp15_ = 0;
	gchar* _tmp16_ = NULL;
	GtkLabel* _tmp17_ = NULL;
	const gchar* _tmp18_ = NULL;
	g_return_if_fail (self != NULL);
	_tmp0_ = self->priv->stack;
	_tmp1_ = gtk_stack_get_visible_child (_tmp0_);
	_tmp2_ = _g_object_ref0 (G_TYPE_CHECK_INSTANCE_TYPE (_tmp1_, gtk_bin_get_type ()) ? ((GtkBin*) _tmp1_) : NULL);
	tab = _tmp2_;
	_tmp3_ = tab;
	if (_tmp3_ == NULL) {
		_g_object_unref0 (tab);
		return;
	}
	_tmp4_ = tab;
	_tmp5_ = gtk_bin_get_child (_tmp4_);
	_tmp6_ = _g_object_ref0 (G_TYPE_CHECK_INSTANCE_TYPE (_tmp5_, gtk_text_view_get_type ()) ? ((GtkTextView*) _tmp5_) : NULL);
	view = _tmp6_;
	_tmp7_ = view;
	_tmp8_ = gtk_text_view_get_buffer (_tmp7_);
	_tmp9_ = _g_object_ref0 (_tmp8_);
	buffer = _tmp9_;
	count = 0;
	_tmp10_ = buffer;
	gtk_text_buffer_get_start_iter (_tmp10_, &_tmp11_);
	iter = _tmp11_;
	while (TRUE) {
		gboolean _tmp12_ = FALSE;
		gint _tmp13_ = 0;
		gboolean _tmp14_ = FALSE;
		_tmp12_ = gtk_text_iter_is_end (&iter);
		if (!(!_tmp12_)) {
			break;
		}
		_tmp13_ = count;
		count = _tmp13_ + 1;
		_tmp14_ = gtk_text_iter_forward_line (&iter);
		if (!_tmp14_) {
			break;
		}
	}
	_tmp15_ = count;
	_tmp16_ = g_strdup_printf ("%d", _tmp15_);
	lns = _tmp16_;
	_tmp17_ = self->priv->lines;
	_tmp18_ = lns;
	gtk_label_set_text (_tmp17_, _tmp18_);
	_g_free0 (lns);
	_g_object_unref0 (buffer);
	_g_object_unref0 (view);
	_g_object_unref0 (tab);
}


static void example_application_window_update_font (ExampleApplicationWindow* self) {
	gchar* font_name = NULL;
	GSettings* _tmp0_ = NULL;
	gchar* _tmp1_ = NULL;
	GtkStack* _tmp2_ = NULL;
	GList* _tmp3_ = NULL;
	g_return_if_fail (self != NULL);
	_tmp0_ = self->priv->settings;
	_tmp1_ = g_settings_get_string (_tmp0_, "font");
	font_name = _tmp1_;
	_tmp2_ = self->priv->stack;
	_tmp3_ = gtk_container_get_children ((GtkContainer*) _tmp2_);
	{
		GList* t_collection = NULL;
		GList* t_it = NULL;
		t_collection = _tmp3_;
		for (t_it = t_collection; t_it != NULL; t_it = t_it->next) {
			GtkWidget* t = NULL;
			t = (GtkWidget*) t_it->data;
			{
				GtkBin* tab = NULL;
				GtkWidget* _tmp4_ = NULL;
				GtkBin* _tmp5_ = NULL;
				GtkTextView* view = NULL;
				GtkBin* _tmp6_ = NULL;
				GtkWidget* _tmp7_ = NULL;
				GtkTextView* _tmp8_ = NULL;
				PangoFontDescription* font = NULL;
				const gchar* _tmp9_ = NULL;
				PangoFontDescription* _tmp10_ = NULL;
				GtkTextView* _tmp11_ = NULL;
				PangoFontDescription* _tmp12_ = NULL;
				_tmp4_ = t;
				_tmp5_ = _g_object_ref0 (G_TYPE_CHECK_INSTANCE_TYPE (_tmp4_, gtk_bin_get_type ()) ? ((GtkBin*) _tmp4_) : NULL);
				tab = _tmp5_;
				_tmp6_ = tab;
				_tmp7_ = gtk_bin_get_child (_tmp6_);
				_tmp8_ = _g_object_ref0 (G_TYPE_CHECK_INSTANCE_TYPE (_tmp7_, gtk_text_view_get_type ()) ? ((GtkTextView*) _tmp7_) : NULL);
				view = _tmp8_;
				_tmp9_ = font_name;
				_tmp10_ = pango_font_description_from_string (_tmp9_);
				font = _tmp10_;
				_tmp11_ = view;
				_tmp12_ = font;
				gtk_widget_override_font ((GtkWidget*) _tmp11_, _tmp12_);
				__vala_PangoFontDescription_free0 (font);
				_g_object_unref0 (view);
				_g_object_unref0 (tab);
			}
		}
		_g_list_free0 (t_collection);
	}
	_g_free0 (font_name);
}


static void example_application_window_class_init (ExampleApplicationWindowClass * klass) {
	gint ExampleApplicationWindow_private_offset;
	example_application_window_parent_class = g_type_class_peek_parent (klass);
	g_type_class_add_private (klass, sizeof (ExampleApplicationWindowPrivate));
	G_OBJECT_CLASS (klass)->finalize = example_application_window_finalize;
	ExampleApplicationWindow_private_offset = g_type_class_get_instance_private_offset (klass);
	gtk_widget_class_set_template_from_resource (GTK_WIDGET_CLASS (klass), "/org/gtk/exampleapp/window.ui");
	gtk_widget_class_bind_template_child_full (GTK_WIDGET_CLASS (klass), "stack", FALSE, ExampleApplicationWindow_private_offset + G_STRUCT_OFFSET (ExampleApplicationWindowPrivate, stack));
	gtk_widget_class_bind_template_child_full (GTK_WIDGET_CLASS (klass), "gears", FALSE, ExampleApplicationWindow_private_offset + G_STRUCT_OFFSET (ExampleApplicationWindowPrivate, gears));
	gtk_widget_class_bind_template_child_full (GTK_WIDGET_CLASS (klass), "search", FALSE, ExampleApplicationWindow_private_offset + G_STRUCT_OFFSET (ExampleApplicationWindowPrivate, search));
	gtk_widget_class_bind_template_child_full (GTK_WIDGET_CLASS (klass), "searchbar", FALSE, ExampleApplicationWindow_private_offset + G_STRUCT_OFFSET (ExampleApplicationWindowPrivate, searchbar));
	gtk_widget_class_bind_template_child_full (GTK_WIDGET_CLASS (klass), "searchentry", FALSE, ExampleApplicationWindow_private_offset + G_STRUCT_OFFSET (ExampleApplicationWindowPrivate, searchentry));
	gtk_widget_class_bind_template_child_full (GTK_WIDGET_CLASS (klass), "sidebar", FALSE, ExampleApplicationWindow_private_offset + G_STRUCT_OFFSET (ExampleApplicationWindowPrivate, sidebar));
	gtk_widget_class_bind_template_child_full (GTK_WIDGET_CLASS (klass), "words", FALSE, ExampleApplicationWindow_private_offset + G_STRUCT_OFFSET (ExampleApplicationWindowPrivate, words));
	gtk_widget_class_bind_template_child_full (GTK_WIDGET_CLASS (klass), "lines_label", FALSE, ExampleApplicationWindow_private_offset + G_STRUCT_OFFSET (ExampleApplicationWindowPrivate, lines_label));
	gtk_widget_class_bind_template_child_full (GTK_WIDGET_CLASS (klass), "lines", FALSE, ExampleApplicationWindow_private_offset + G_STRUCT_OFFSET (ExampleApplicationWindowPrivate, lines));
	gtk_widget_class_bind_template_callback_full (GTK_WIDGET_CLASS (klass), "visible_child_changed", G_CALLBACK(_example_application_window_visible_child_changed_g_object_notify));
	gtk_widget_class_bind_template_callback_full (GTK_WIDGET_CLASS (klass), "search_text_changed", G_CALLBACK(_example_application_window_search_text_changed_gtk_search_entry_search_changed));
}


static void example_application_window_instance_init (ExampleApplicationWindow * self) {
	self->priv = EXAMPLE_APPLICATION_WINDOW_GET_PRIVATE (self);
	gtk_widget_init_template (GTK_WIDGET (self));
}


static void example_application_window_finalize (GObject* obj) {
	ExampleApplicationWindow * self;
	self = G_TYPE_CHECK_INSTANCE_CAST (obj, EXAMPLE_TYPE_APPLICATION_WINDOW, ExampleApplicationWindow);
	_g_object_unref0 (self->priv->stack);
	_g_object_unref0 (self->priv->gears);
	_g_object_unref0 (self->priv->search);
	_g_object_unref0 (self->priv->searchbar);
	_g_object_unref0 (self->priv->searchentry);
	_g_object_unref0 (self->priv->sidebar);
	_g_object_unref0 (self->priv->words);
	_g_object_unref0 (self->priv->lines_label);
	_g_object_unref0 (self->priv->lines);
	_g_object_unref0 (self->priv->settings);
	G_OBJECT_CLASS (example_application_window_parent_class)->finalize (obj);
}


GType example_application_window_get_type (void) {
	static volatile gsize example_application_window_type_id__volatile = 0;
	if (g_once_init_enter (&example_application_window_type_id__volatile)) {
		static const GTypeInfo g_define_type_info = { sizeof (ExampleApplicationWindowClass), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) example_application_window_class_init, (GClassFinalizeFunc) NULL, NULL, sizeof (ExampleApplicationWindow), 0, (GInstanceInitFunc) example_application_window_instance_init, NULL };
		GType example_application_window_type_id;
		example_application_window_type_id = g_type_register_static (gtk_application_window_get_type (), "ExampleApplicationWindow", &g_define_type_info, 0);
		g_once_init_leave (&example_application_window_type_id__volatile, example_application_window_type_id);
	}
	return example_application_window_type_id__volatile;
}



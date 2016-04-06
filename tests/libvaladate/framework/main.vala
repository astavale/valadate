namespace Valadate.Framework.Tests {

	static void main (string[] args) {

		GLib.Test.init (ref args);

		add_test_config_tests();

		add_text_runner_tests();

		add_test_case_tests();

		add_assert_tests();

		GLib.Test.run ();

	}
}

namespace Valadate.Framework.Tests {

	void add_assert_tests () {

		GLib.Test.add_func ("/assert/equals/string", () => {
			string t1 = "test";
			string t2 = "test";
			
			Assert.equals(t1, t2, "Values must be equal");
		});

		GLib.Test.add_func ("/assert/equals/int", () => {
			int t1 = 45678;
			int t2 = 45678;
			
			Assert.equals(t1, t2, "Values must be equal");
		});

		GLib.Test.add_func ("/assert/equals", () => {
			GLib.Test.trap_subprocess("/assert/equals/subprocess", 0,0);
			GLib.Test.trap_assert_failed();
		});

		GLib.Test.add_func ("/assert/equals/subprocess", () => {
			Assert.equals(24, 23, "Values must be equal");
		});

		GLib.Test.add_func ("/assert/null", () => {
			void* nullval = null;

			Assert.null(nullval, "Value must be null");
		});

		GLib.Test.add_func ("/assert/null/fail", () => {
			GLib.Test.trap_subprocess("/assert/null/fail/subprocess", 0,0);
			GLib.Test.trap_assert_failed();
		});

		GLib.Test.add_func ("/assert/null/fail/subprocess", () => {
			string nullval = "test";

			Assert.null(nullval, "Value must be null");
		});

		GLib.Test.add_func ("/assert/not_null", () => {
			string nullval = "test";

			Assert.not_null(nullval, "Value must not be null");
		});

		GLib.Test.add_func ("/assert/not_null/fail", () => {
			GLib.Test.trap_subprocess("/assert/not_null/fail/subprocess", 0,0);

			GLib.Test.trap_assert_failed();
		});

		GLib.Test.add_func ("/assert/not_null/fail/subprocess", () => {
			void* nullval = null;

			Assert.not_null(nullval, "Value must not be null");
		});

	}
}

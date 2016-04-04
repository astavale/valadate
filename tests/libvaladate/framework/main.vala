namespace Valadate.Framework.Tests {

	public class TestTestCase : TestCase {
		
		
	}

	static void main (string[] args) {

		GLib.Test.init (ref args);


		GLib.Test.add_func ("/Framework/TestConfig/new", () => {
			TestConfig conf = new TestConfig();
			
			assert(conf != null);
		});

		GLib.Test.add_func ("/Framework/parse_args/k", () => {

			string[] testargs = {"-k"};
			
			var conf = parse_args(ref testargs);
			
			assert(conf.mode_fatal != true);
		});

		GLib.Test.add_func ("/Framework/parse_args/keep-going", () => {

			string[] testargs = {"--keep-going"};
			
			var conf = parse_args(ref testargs);
			
			assert(conf.mode_fatal != true);
		});

		GLib.Test.add_func ("/Framework/parse_args/debug-log", () => {

			string[] testargs = {"--debug-log"};
			
			var conf = parse_args(ref testargs);
			
			assert(conf.debug_log == true);
		});

		GLib.Test.add_func ("/Framework/parse_args/tap", () => {

			string[] testargs = {"--tap"};
			
			var conf = parse_args(ref testargs);
			
			assert(conf.tap_log == true);
		});

		GLib.Test.add_func ("/Framework/parse_args/GTestLogFD", () => {

			string[] testargs = {"--GTestLogFD", "12345"};
			
			var conf = parse_args(ref testargs);
			
			assert(conf.log_fd == 12345);
		});

		GLib.Test.add_func ("/Framework/parse_args/GTestLogFD/Param", () => {

			string[] testargs = {"--GTestLogFD=12345"};
			
			var conf = parse_args(ref testargs);
			
			assert(conf.log_fd == 12345);
		});

		GLib.Test.add_func ("/Framework/parse_args/GTestSkipCount", () => {

			string[] testargs = {"--GTestSkipCount","2"};
			
			var conf = parse_args(ref testargs);
			
			assert(conf.startup_skip_count == 2);
		});

		GLib.Test.add_func ("/Framework/parse_args/GTestSkipCount/Param", () => {

			string[] testargs = {"--GTestSkipCount=2"};
			
			var conf = parse_args(ref testargs);
			
			assert(conf.startup_skip_count == 2);
		});

		GLib.Test.add_func ("/Framework/parse_args/GTestSubprocess", () => {

			string[] testargs = {"--GTestSubprocess"};
			
			var conf = parse_args(ref testargs);
			
			assert(conf.in_subprocess == true);
		});

		GLib.Test.add_func ("/Framework/parse_args/m/perf", () => {

			string[] testargs = {"-m","perf"};
			
			var conf = parse_args(ref testargs);
			
			assert(conf.perf == true);
		});

		GLib.Test.add_func ("/Framework/parse_args/m/perf/param", () => {

			string[] testargs = {"-m=perf"};
			
			var conf = parse_args(ref testargs);
			
			assert(conf.perf == true);
		});

		GLib.Test.add_func ("/Framework/parse_args/m/slow", () => {

			string[] testargs = {"-m","slow"};
			
			var conf = parse_args(ref testargs);
			
			assert(conf.quick == false);
		});

		GLib.Test.add_func ("/Framework/parse_args/m/slow/param", () => {

			string[] testargs = {"-m=slow"};
			
			var conf = parse_args(ref testargs);
			
			assert(conf.quick == false);
		});

		GLib.Test.add_func ("/Framework/parse_args/m/thorough", () => {

			string[] testargs = {"-m","thorough"};
			
			var conf = parse_args(ref testargs);
			
			assert(conf.quick == false);
		});

		GLib.Test.add_func ("/Framework/parse_args/m/quick", () => {

			string[] testargs = {"-m","quick"};
			
			var conf = parse_args(ref testargs);
			
			assert(conf.quick == true);
			assert(conf.perf == false);
		});

		GLib.Test.add_func ("/Framework/parse_args/m/undefined", () => {

			string[] testargs = {"-m","undefined"};
			
			var conf = parse_args(ref testargs);
			
			assert(conf.undefined == true);
		});

		GLib.Test.add_func ("/Framework/parse_args/m/no-undefined", () => {

			string[] testargs = {"-m","no-undefined"};
			
			var conf = parse_args(ref testargs);
			
			assert(conf.undefined == false);
		});

		GLib.Test.add_func ("/Framework/parse_args/quiet", () => {

			string[] testargs = {"--quiet"};
			
			var conf = parse_args(ref testargs);
			
			assert(conf.quiet == true);
			assert(conf.verbose == false);
		});

		GLib.Test.add_func ("/Framework/parse_args/q", () => {

			string[] testargs = {"-q"};
			
			var conf = parse_args(ref testargs);
			
			assert(conf.quiet == true);
			assert(conf.verbose == false);
		});

		GLib.Test.add_func ("/Framework/parse_args/verbose", () => {

			string[] testargs = {"--verbose"};
			
			var conf = parse_args(ref testargs);
			
			assert(conf.quiet == false);
			assert(conf.verbose == true);
		});

		GLib.Test.add_func ("/Framework/parse_args/l", () => {

			string[] testargs = {"-l"};
			
			var conf = parse_args(ref testargs);
			
			assert(conf.run_list == true);
		});

		GLib.Test.add_func ("/Framework/parse_args/seed", () => {

			string[] testargs = {"--seed","atotallyrandomseedstring"};
			
			var conf = parse_args(ref testargs);
			
			assert(conf.seedstr == "atotallyrandomseedstring");
		});

		GLib.Test.add_func ("/Framework/parse_args/seed/param", () => {

			string[] testargs = {"--seed=atotallyrandomseedstring"};
			
			var conf = parse_args(ref testargs);
			
			assert(conf.seedstr == "atotallyrandomseedstring");
		});

		GLib.Test.add_func ("/Framework/parse_args/help", () => {

			string[] testargs = {"-h"};
			
			var conf = parse_args(ref testargs);
			
			assert(conf.show_help == true);
		});

		GLib.Test.add_func ("/Framework/parse_args/p", () => {

			string[] testargs = {"-p", "/MyTest/Path","-p", "/MyTest/Path/2"};
			
			var conf = parse_args(ref testargs);
			
			assert(conf.test_paths.length() == 2);
		});

		GLib.Test.add_func ("/Framework/parse_args/p/param", () => {

			string[] testargs = {"-p=/MyTest/Path","-p=/MyTest/Path/2"};
			
			var conf = parse_args(ref testargs);
			
			assert(conf.test_paths.length() == 2);
		});




		GLib.Test.add_func ("/testcase/new", () => {
			TestCase test = new TestTestCase();
			assert(test is TestCase);
			assert(test.suite != null);
		});

		GLib.Test.add_func ("/testcase/add_test", () => {
			TestCase test = new TestTestCase();
			test.add_test("add_test", ()=> { assert(true); });
			assert(test is TestCase);
		});

		GLib.Test.add_func ("/textrunner/new", () => {
			string testexe = Config.VALADATE_TESTS_DIR +"/libvaladate/data/.libs/testexe-0";
			TextRunner runner = new TextRunner(testexe);
			assert(runner is TextRunner);
		});

		/*
		GLib.Test.add_func ("/textrunner/load_module", () => {
			string testexe = Config.VALADATE_TESTS_DIR +"/libvaladate/data/.libs/lt-testexe-0";
			TextRunner runner = new TextRunner(testexe);
			try {
				runner.load_module();
			} catch (RunError err) {
				debug(err.message);
				assert_not_reached();
			}
		});

		GLib.Test.add_func ("/textrunner/load_gir", () => {
			string testexe = Config.VALADATE_TESTS_DIR +"/libvaladate/data/.libs/lt-testexe-0";
			TextRunner runner = new TextRunner(testexe);
			try {
				runner.load_module();
				runner.load_gir();
			} catch (RunError err) {
				debug(err.message);
				assert_not_reached();
			}
		});

		GLib.Test.add_func ("/textrunner/load_tests", () => {
			string testexe = Config.VALADATE_TESTS_DIR +"/libvaladate/data/.libs/lt-testexe-0";
			TextRunner runner = new TextRunner(testexe);
			assert(runner.tests.length == 0);
			try {
				//runner.load_module();
				//runner.load_gir();
				runner.load_tests();
			} catch (RunError err) {
				debug(err.message);
				assert_not_reached();
			}
			assert(runner.tests.length == 2);
			assert(((TestCase)runner.tests[0]).name == "ValadateFrameworkTestsTestExe");
			assert(((TestCase)runner.tests[1]).name == "ValadateFrameworkTestsTestExeTwo");
		});

		GLib.Test.add_func ("/textrunner/load", () => {
			string testexe = Config.VALADATE_TESTS_DIR +"/libvaladate/data/.libs/testexe-0";
			TextRunner runner = new TextRunner(testexe);
			assert(runner.tests.length == 0);
			try {
				runner.load();
			} catch (RunError err) {
				debug(err.message);
				assert_not_reached();
			}
			assert(runner.tests.length == 3);
			assert(((TestCase)runner.tests[0]).name == "ValadateFrameworkTestsTestExeTwo");
			assert(((TestCase)runner.tests[1]).name == "ValadateFrameworkTestsTestExe");
		});*/

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

		GLib.Test.run ();

	}
}

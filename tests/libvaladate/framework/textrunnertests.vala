namespace Valadate.Framework.Tests {


	/**
	 * - TestConfig
	 * - TestResult
	 * - TestSuite
	 * - TestCase
	 * - Sub Classes??
	 * 
	 * - Parse args and create TestConfig
	 * - Create new TextRunner with TestConfig
	 * - Run the TextRunner
	 *   - checks for and loads the tests from the test binary
	 *   - if no test binary uses introspection to find Tests*
	 *   - checks for embedded TestConfig which overrides some parsed options
	 *   - sets up test environement and runs tests according to TestConfig
	 *     - noargs - runs all found tests in subprocesses using -p
	 *     -p TESTPATH - runs the tests at TESTPATH
	 *        - if only one test is found, run it
	 *        - otherwise, spawn new processes to run each test in the path
	 *     -s TESTPATH - skips the tests at TESTPATH
	 *     -l - lists all of the tests found in the test binary
	 *     --help - outputs help
	 *     - the other options are configuration settings for the test env
	 * - Get TestResult from TextRunner and output results
	 * 
	 */

	public const string TEST_BINARY = Config.VALADATE_TESTS_DIR +"/libvaladate/data/.libs/testexe-0";


	void add_text_runner_tests() {

		GLib.Test.add_func ("/Framework/TextRunner/new", () => {
			string[] testargs = {TEST_BINARY, "-p=/My Test/Path","-p=/MyTest/Path/2"};
			unowned string[] weakargs = testargs;
			var conf = new TestConfig.from_params(ref weakargs);
			
			TextRunner runner = new TextRunner(conf);
			
			assert(runner is TextRunner);
		});


		GLib.Test.add_func ("/Framework/TextRunner/load_test_plan", () => {
			string[] testargs = {TEST_BINARY};
			unowned string[] weakargs = testargs;
			var conf = new TestConfig.from_params(ref weakargs);
			TextRunner runner = new TextRunner(conf);
			
			try {
				runner.load_test_plan();
			} catch (RunError err) {
				debug(err.message);
				assert_not_reached();
			}
		});
		

		GLib.Test.add_func ("/Framework/TextRunner/load_binary", () => {
			string[] testargs = {TEST_BINARY};
			unowned string[] weakargs = testargs;
			var conf = new TestConfig.from_params(ref weakargs);
			TextRunner runner = new TextRunner(conf);
			runner.load_test_plan();
			
			try {
				runner.load_binary();
			} catch (RunError err) {
				debug(err.message);
				assert_not_reached();
			}
		});
		

		GLib.Test.add_func ("/Framework/TextRunner/load_tests", () => {
			string[] testargs = {TEST_BINARY, "-p=/MyTest/Path","-p=/MyTest/Path/2"};
			unowned string[] weakargs = testargs;
			var conf = new TestConfig.from_params(ref weakargs);
			TextRunner runner = new TextRunner(conf);
			runner.load_test_plan();
			runner.load_binary();

			assert(runner.tests.length == 0);

			try {
				runner.load_tests();
			} catch (RunError err) {
				debug(err.message);
				assert_not_reached();
			}

			assert(runner.tests.length == 3);
			assert(((TestCase)runner.tests[0]).name == "FrameworkTestsTestExeTwo");
			assert(((TestCase)runner.tests[1]).name == "FrameworkTestsTestExe");
		});

		GLib.Test.add_func ("/Framework/TextRunner/run/list/subprocess", () => {
			Array<string> argsa = new Array<string>();
			argsa.append_val(TEST_BINARY);
			argsa.append_val("-l");
			argsa.append_val("--tap");
			unowned string[] weakargs = argsa.data;
			
			var conf = new TestConfig.from_params(ref weakargs);
			TextRunner runner = new TextRunner(conf);
			var result = runner.run();
			result.report();

			
		});
		
		GLib.Test.add_func ("/Framework/TextRunner/run/list", () => {
			GLib.Test.trap_subprocess ("/Framework/TextRunner/run/list/subprocess", 0, 0);
			GLib.Test.trap_assert_passed ();

			var teststr =
"""# random seed: *
1..9
# Start of FrameworkTestsTestExeTwo tests
/FrameworkTestsTestExeTwo/Test One
/FrameworkTestsTestExeTwo/Test Two
/FrameworkTestsTestExeTwo/Test Async with Timeout
# End of FrameworkTestsTestExeTwo tests
# Start of FrameworkTestsTestExe tests
/FrameworkTestsTestExe/simple
/FrameworkTestsTestExe/simple_skip
/FrameworkTestsTestExe/Annotated Test With Name
/FrameworkTestsTestExe/Asynchronous Test
/FrameworkTestsTestExe/skip_test
# End of FrameworkTestsTestExe tests
# Start of Annotated Test Class With Name tests
/Annotated Test Class With Name/method
# End of Annotated Test Class With Name tests""";

			GLib.Test.trap_assert_stdout("FrameworkTestsTestExeTwo\nFrameworkTestsTestExe\nAnnotated Test Class With Name\n");
			//GLib.Test.trap_assert_stdout(teststr);

		});
	
	}

}

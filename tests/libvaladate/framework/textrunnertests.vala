namespace Valadate.Framework.Tests {

	void add_text_runner_tests() {

		GLib.Test.add_func ("/Framework/TextRunner/new", () => {
			string[] testargs = {Config.VALADATE_TESTS_DIR +"/libvaladate/data/.libs/testexe-0", "-p=/My Test/Path","-p=/MyTest/Path/2"};
			unowned string[] weakargs = testargs;
			var conf = new TestConfig.from_params(ref weakargs);
			
			TextRunner runner = new TextRunner(conf);
			
			assert(runner is TextRunner);
		});


		GLib.Test.add_func ("/Framework/TextRunner/load_module", () => {
			string[] testargs = {Config.VALADATE_TESTS_DIR +"/libvaladate/data/.libs/testexe-0", "-p=/MyTest/Path","-p=/MyTest/Path/2"};
			unowned string[] weakargs = testargs;
			var conf = new TestConfig.from_params(ref weakargs);
			TextRunner runner = new TextRunner(conf);
			
			try {
				runner.load();
			} catch (RunError err) {
				debug(err.message);
				assert_not_reached();
			}
		});
		

		GLib.Test.add_func ("/Framework/TextRunner/load_tests", () => {
			string[] testargs = {Config.VALADATE_TESTS_DIR +"/libvaladate/data/.libs/testexe-0", "-p=/MyTest/Path","-p=/MyTest/Path/2"};
			unowned string[] weakargs = testargs;
			var conf = new TestConfig.from_params(ref weakargs);
			TextRunner runner = new TextRunner(conf);

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
			argsa.append_val(Config.VALADATE_TESTS_DIR +"/libvaladate/data/.libs/testexe-0");
			argsa.append_val("-l");
			unowned string[] weakargs = argsa.data;
			
			var conf = new TestConfig.from_params(ref weakargs);
			TextRunner runner = new TextRunner(conf);
			runner.run();


			
		});
		
		GLib.Test.add_func ("/Framework/TextRunner/run/list", () => {
			GLib.Test.trap_subprocess ("/Framework/TextRunner/run/list/subprocess", 0, 0);
			GLib.Test.trap_assert_passed ();
			GLib.Test.trap_assert_stdout("FrameworkTestsTestExeTwo\nFrameworkTestsTestExe\nAnnotated Test Class With Name\n");

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


		});
	
	}

}

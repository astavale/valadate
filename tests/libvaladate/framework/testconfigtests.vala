namespace Valadate.Framework.Tests {

	void add_test_config_tests() {
		
		GLib.Test.add_func ("/Framework/TestConfig/new", () => {
			TestConfig conf = new TestConfig();
			
			assert(conf != null);
		});

		GLib.Test.add_func ("/Framework/TestConfig/new/from_params/k", () => {

			string[] testargs = {"-k"};
			unowned string[] weakargs = testargs;
			
			
			var conf = new TestConfig.from_params(ref weakargs);
			
			assert(conf.mode_fatal != true);
		});

		GLib.Test.add_func ("/Framework/TestConfig/new/from_params/keep-going", () => {

			string[] testargs = {"--keep-going"};
			unowned string[] weakargs = testargs;
			
			var conf = new TestConfig.from_params(ref weakargs);
			
			assert(conf.mode_fatal != true);
		});

		GLib.Test.add_func ("/Framework/TestConfig/new/from_params/debug-log", () => {

			string[] testargs = {"--debug-log"};
			unowned string[] weakargs = testargs;
			
			var conf = new TestConfig.from_params(ref weakargs);
			
			assert(conf.debug_log == true);
		});

		GLib.Test.add_func ("/Framework/TestConfig/new/from_params/tap", () => {

			string[] testargs = {"--tap"};
			unowned string[] weakargs = testargs;
			
			var conf = new TestConfig.from_params(ref weakargs);
			
			assert(conf.tap_log == true);
		});

		GLib.Test.add_func ("/Framework/TestConfig/new/from_params/GTestLogFD", () => {

			string[] testargs = {"--GTestLogFD", "12345"};
			unowned string[] weakargs = testargs;
			
			var conf = new TestConfig.from_params(ref weakargs);
			
			assert(conf.log_fd == 12345);
		});

		GLib.Test.add_func ("/Framework/TestConfig/new/from_params/GTestLogFD/Param", () => {

			string[] testargs = {"--GTestLogFD=12345"};
			unowned string[] weakargs = testargs;
			
			var conf = new TestConfig.from_params(ref weakargs);
			
			assert(conf.log_fd == 12345);
		});

		GLib.Test.add_func ("/Framework/TestConfig/new/from_params/GTestSkipCount", () => {

			string[] testargs = {"--GTestSkipCount","2"};
			unowned string[] weakargs = testargs;
			
			var conf = new TestConfig.from_params(ref weakargs);
			
			assert(conf.startup_skip_count == 2);
		});

		GLib.Test.add_func ("/Framework/TestConfig/new/from_params/GTestSkipCount/Param", () => {

			string[] testargs = {"--GTestSkipCount=2"};
			unowned string[] weakargs = testargs;
			
			var conf = new TestConfig.from_params(ref weakargs);
			
			assert(conf.startup_skip_count == 2);
		});

		GLib.Test.add_func ("/Framework/TestConfig/new/from_params/GTestSubprocess", () => {

			string[] testargs = {"--GTestSubprocess"};
			unowned string[] weakargs = testargs;
			
			var conf = new TestConfig.from_params(ref weakargs);
			
			assert(conf.in_subprocess == true);
		});

		GLib.Test.add_func ("/Framework/TestConfig/new/from_params/m/perf", () => {

			string[] testargs = {"-m","perf"};
			unowned string[] weakargs = testargs;
			
			var conf = new TestConfig.from_params(ref weakargs);
			
			assert(conf.perf == true);
		});

		GLib.Test.add_func ("/Framework/TestConfig/new/from_params/m/perf/param", () => {

			string[] testargs = {"-m=perf"};
			unowned string[] weakargs = testargs;
			
			var conf = new TestConfig.from_params(ref weakargs);
			
			assert(conf.perf == true);
		});

		GLib.Test.add_func ("/Framework/TestConfig/new/from_params/m/slow", () => {

			string[] testargs = {"-m","slow"};
			unowned string[] weakargs = testargs;
			
			var conf = new TestConfig.from_params(ref weakargs);
			
			assert(conf.quick == false);
		});

		GLib.Test.add_func ("/Framework/TestConfig/new/from_params/m/slow/param", () => {

			string[] testargs = {"-m=slow"};
			unowned string[] weakargs = testargs;
			
			var conf = new TestConfig.from_params(ref weakargs);
			
			assert(conf.quick == false);
		});

		GLib.Test.add_func ("/Framework/TestConfig/new/from_params/m/thorough", () => {

			string[] testargs = {"-m","thorough"};
			unowned string[] weakargs = testargs;
			
			var conf = new TestConfig.from_params(ref weakargs);
			
			assert(conf.quick == false);
		});

		GLib.Test.add_func ("/Framework/TestConfig/new/from_params/m/quick", () => {

			string[] testargs = {"-m","quick"};
			unowned string[] weakargs = testargs;
			
			var conf = new TestConfig.from_params(ref weakargs);
			
			assert(conf.quick == true);
			assert(conf.perf == false);
		});

		GLib.Test.add_func ("/Framework/TestConfig/new/from_params/m/undefined", () => {

			string[] testargs = {"-m","undefined"};
			unowned string[] weakargs = testargs;
			
			var conf = new TestConfig.from_params(ref weakargs);
			
			assert(conf.undefined == true);
		});

		GLib.Test.add_func ("/Framework/TestConfig/new/from_params/m/no-undefined", () => {

			string[] testargs = {"-m","no-undefined"};
			unowned string[] weakargs = testargs;
			
			var conf = new TestConfig.from_params(ref weakargs);
			
			assert(conf.undefined == false);
		});

		GLib.Test.add_func ("/Framework/TestConfig/new/from_params/quiet", () => {

			string[] testargs = {"--quiet"};
			unowned string[] weakargs = testargs;
			
			var conf = new TestConfig.from_params(ref weakargs);
			
			assert(conf.quiet == true);
			assert(conf.verbose == false);
		});

		GLib.Test.add_func ("/Framework/TestConfig/new/from_params/q", () => {

			string[] testargs = {"-q"};
			unowned string[] weakargs = testargs;
			
			var conf = new TestConfig.from_params(ref weakargs);
			
			assert(conf.quiet == true);
			assert(conf.verbose == false);
		});

		GLib.Test.add_func ("/Framework/TestConfig/new/from_params/verbose", () => {

			string[] testargs = {"--verbose"};
			unowned string[] weakargs = testargs;
			
			var conf = new TestConfig.from_params(ref weakargs);
			
			assert(conf.quiet == false);
			assert(conf.verbose == true);
		});

		GLib.Test.add_func ("/Framework/TestConfig/new/from_params/l", () => {

			string[] testargs = {"-l"};
			unowned string[] weakargs = testargs;
			
			var conf = new TestConfig.from_params(ref weakargs);
			
			assert(conf.run_list == true);
		});

		GLib.Test.add_func ("/Framework/TestConfig/new/from_params/seed", () => {

			string[] testargs = {"--seed","atotallyrandomseedstring"};
			unowned string[] weakargs = testargs;
			
			var conf = new TestConfig.from_params(ref weakargs);
			
			assert(conf.seedstr == "atotallyrandomseedstring");
		});

		GLib.Test.add_func ("/Framework/TestConfig/new/from_params/seed/param", () => {

			string[] testargs = {"--seed=atotallyrandomseedstring"};
			unowned string[] weakargs = testargs;
			
			var conf = new TestConfig.from_params(ref weakargs);
			
			assert(conf.seedstr == "atotallyrandomseedstring");
		});

		GLib.Test.add_func ("/Framework/TestConfig/new/from_params/help", () => {

			string[] testargs = {"-h"};
			unowned string[] weakargs = testargs;
			
			var conf = new TestConfig.from_params(ref weakargs);
			
			assert(conf.show_help == true);
		});

		GLib.Test.add_func ("/Framework/TestConfig/new/from_params/p", () => {

			string[] testargs = {"-p", "/MyTest/Path","-p", "/MyTest/Path/2"};
			unowned string[] weakargs = testargs;
			
			var conf = new TestConfig.from_params(ref weakargs);
			
			assert(conf.test_paths.length() == 2);
		});

		GLib.Test.add_func ("/Framework/TestConfig/new/from_params/p/param", () => {

			string[] testargs = {"-p=/MyTest/Path","-p=/MyTest/Path/2"};
			unowned string[] weakargs = testargs;
			
			var conf = new TestConfig.from_params(ref weakargs);
			
			assert(conf.test_paths.length() == 2);
		});
		
	}

}

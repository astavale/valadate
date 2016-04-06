/*
 * Valadate - Unit testing library for GObject-based libraries.
 * Copyright (C) 20016  Chris Daley <chebizarro@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published
 * by the Free Software Foundation, either version 3 of the License, or (at
 * your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
 * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
 * License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

namespace Valadate.Framework {

	internal const string HELP_STR =
		"Usage:\n" +
		"  %s [OPTION...]\n\n" +
		"Help Options:\n" +
		"  -h, --help                     Show help options\n\n" +
		"Test Options:\n" +
		"  --g-fatal-warnings             Make all warnings fatal\n" +
		"  -l                             List test cases available in a test executable\n" +
		"  -m {perf|slow|thorough|quick}  Execute tests according to mode\n" +
		"  -m {undefined|no-undefined}    Execute tests according to mode\n" +
		"  -p TESTPATH                    Only start test cases matching TESTPATH\n" +
		"  -s TESTPATH                    Skip all tests matching TESTPATH\n" +
		"  -seed=SEEDSTRING               Start tests with random seed SEEDSTRING\n" +
		"  --debug-log                    debug test logging output\n" +
		"  -q, --quiet                    Run tests quietly\n" +
		"  --verbose                      Run tests verbosely\n";


	/**
	 * init:
	 * @argc: Address of the @argc parameter of the main() function.
	 *        Changed if any arguments were handled.
	 * @argv: Address of the @argv parameter of main().
	 *        Any parameters understood by g_test_init() stripped before return.
	 * @...: %NULL-terminated list of special options. Currently the only
	 *       defined option is `"no_g_set_prgname"`, which
	 *       will cause g_test_init() to not call g_set_prgname().
	 *
	 * Initialize the GLib testing framework, e.g. by seeding the
	 * test random number generator, the name for g_get_prgname()
	 * and parsing test related command line args.
	 *
	 * So far, the following arguments are understood:
	 *
	 * - `-l`: List test cases available in a test executable.
	 * - `--seed=SEED`: Provide a random seed to reproduce test
	 *   runs using random numbers.
	 * - `--verbose`: Run tests verbosely.
	 * - `-q`, `--quiet`: Run tests quietly.
	 * - `-p PATH`: Execute all tests matching the given path.
	 *   This can also be used to force a test to run that would otherwise
	 *   be skipped (ie, a test whose name contains "/subprocess").
	 * - `-m {perf|slow|thorough|quick|undefined|no-undefined}`: Execute tests according to these test modes:
	 *
	 *   `perf`: Performance tests, may take long and report results.
	 *
	 *   `slow`, `thorough`: Slow and thorough tests, may take quite long and maximize coverage.
	 *
	 *   `quick`: Quick tests, should run really quickly and give good coverage.
	 *
	 *   `undefined`: Tests for undefined behaviour, may provoke programming errors
	 *   under g_test_trap_subprocess() or g_test_expect_messages() to check
	 *   that appropriate assertions or warnings are given
	 *
	 *   `no-undefined`: Avoid tests for undefined behaviour
	 *
	 * - `--debug-log`: Debug test logging output.
	 *
	 * Since: 2.16
	 */
	public static void init(ref string[] args) {
		
		/* make warnings and criticals fatal for all test programs */
		GLib.LogLevelFlags fatal_mask = Log.set_always_fatal(LogLevelFlags.FLAG_RECURSION | LogLevelFlags.LEVEL_ERROR );
		fatal_mask = fatal_mask | LogLevelFlags.LEVEL_WARNING | LogLevelFlags.LEVEL_CRITICAL;
		Log.set_always_fatal(fatal_mask);

		//if ("no_g_set_prgname" in args)
			//no_g_set_prgname = true;
			
		var seedstr = "R02S%08x%08x%08x%08x".printf(Random.next_int(), Random.next_int(), Random.next_int(), Random.next_int());
		
		//if(GLib.Environment.get_prgname() == null && !no_g_set_prgname)
		//	GLib.Environment.set_prgname(args[0]);
		
		TestConfig config = new TestConfig();
		
		
	}


#if HAVE_SYS_RESOURCE_H
	struct rlimit {
		long rlim_cur;
		long rlim_max;
	}
	
	[ CCode (cname = "setrlimit", cheader_filename = "sys/resource.h") ]
	extern int setrlimit(int resource, rlimit rlim);
	
	int RLIMIT_CORE = 4;
#endif


}

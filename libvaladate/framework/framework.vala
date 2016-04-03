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

	internal static bool no_g_set_prgname = true;
	internal static bool tap_log = false;
	internal static bool mode_fatal = true;
	internal static bool debug_log = false;
	internal static bool in_subprocess = false;

	internal static string seedstr;
	internal static string argv0;
	internal static string initial_cwd;

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
		
		GLib.LogLevelFlags fatal_mask = Log.set_always_fatal(LogLevelFlags.FLAG_RECURSION | LogLevelFlags.LEVEL_ERROR );
		fatal_mask = fatal_mask | LogLevelFlags.LEVEL_WARNING | LogLevelFlags.LEVEL_CRITICAL;
		Log.set_always_fatal(fatal_mask);

		if ("no_g_set_prgname" in args)
			no_g_set_prgname = true;
			
		seedstr = "R02S%08x%08x%08x%08x".printf(Random.next_int(), Random.next_int(), Random.next_int(), Random.next_int());
		
		if(GLib.Environment.get_prgname() == null && !no_g_set_prgname)
			GLib.Environment.set_prgname(args[0])
		
		parse_args(ref args);
		
		
		if(tap_log)
	}


	private static void parse_args(ref string[] args, ref TestConfig config) {
	
		var conf = config ?? new TestConfig();
		
		argv0 = args[0];
		initial_cwd = GLib.Environment.get_current_dir();
		
		for (int i=0; i < args.length; i++) {
		
			if("--g-fatal-warnings" == args[i]) {
				LogLevelFlags fatal_mask = Log.set_always_fatal(LogLevelFlags.FLAG_RECURSION | LogLevelFlags.LEVEL_ERROR );
				fatal_mask = fatal_mask | LogLevelFlags.LEVEL_WARNING | LogLevelFlags.LEVEL_CRITICAL;
				Log.set_always_fatal(fatal_mask);
			}
			else if("--keep-going" == args[i] || "-k" == args[i])
				conf.mode_fatal = false;
				
			else if("--debug-log" == args[i])
				conf.debug_log = true;
				
			else if("--tap" == args[i])
				conf.tap_log = true;

			if(args[i].index_of("--GTestLogFD") == 0) {
				if(args[i].length > 12)
					if(args[i].data[13] == '=')
						conf.log_fd = int64.ascii_strtoll (args[i].substring(14), null, 0);
					else if (i + 1 < args.length)
						conf.log_fd = int64.ascii_strtoll (args[++i], null, 0);
					
			}

			if(args[i].index_of("--GTestSkipCount") == 0) {
				if(args[i].length > 16) {
					if(args[i].data[17] == '=')
						conf.startup_skip_count = int64.ascii_strtoll (args[i].substring(18), null, 0);
					else if (i + 1 < args.length)
						conf.startup_skip_count = int64.ascii_strtoll (args[++i], null, 0);

				}
			}

			
			if("--GTestSubprocess" == arg) {
				conf.in_subprocess = true;
				// resource limit check and set rlimit
				#if HAVE_SYS_RESOURCE_H
				//rlimit limit = { 0, 0 };
				//setrlimit (4, limit);
				#endif
				
			}
			
			if(args[i].index_of("-p") == 0) {
				if(args[i].data[3] == '=')
					// add test
				else if (i + 1 < args.length)
					// add test
			}

			if(args[i].index_of("-s") == 0) {
				if(args[i].data[3] == '=')
					// skip test
				else if (i + 1 < args.length)
					// skip test
			}
			
			if(args[i].index_of("-m") == 0) {
				string mode = "";
				if(args[i].data[3] == '=')
					mode = args[i].substring(3);
				else if (i + 1 < args.length)
					mode = args[++i];
				
				switch (mode) {
					case "perf":
						conf.perf = true;
						break;
					case "slow":
						conf.quick = false;
						break;
					case "thorough":
						conf.quick = true;
						break;
					case "quick":
						conf.quick = true;
						conf.perf = false;
						break;
					case "undefined":
						conf.undefined = true;
						break;
					case "no-undefined":
						conf.undefined = false;
						break;
					default:
						// throw ("unknown test mode: -m %s", mode);
						break;
				
				}

			}
			
			if("--quiet" == args[i] || "-q" == args[i]) {
				conf.quiet = true;
				conf.verbose = false;
			}
	
			if("--verbose" == args[i] || "-v" == args[i]) {
				conf.quiet = false;
				conf.verbose = true;
			}
			
			if("-l" == args[i])
				conf.run_list = true;

			if(args[i].index_of("--seed") == 0) {
				if(args[i].data[6] == '=')
					conf.seedstr = args[i].substring(6);
				else if (i + 1 < args.length)
					conf.seedstr = args[++i];
			}
			
			if("--help" == args[i] || "-h" == args[i] || "-?" == args[i]) {
				
				printf ("Usage:\n"
					"  %s [OPTION...]\n\n"
					"Help Options:\n"
					"  -h, --help                     Show help options\n\n"
					"Test Options:\n"
					"  --g-fatal-warnings             Make all warnings fatal\n"
					"  -l                             List test cases available in a test executable\n"
					"  -m {perf|slow|thorough|quick}  Execute tests according to mode\n"
					"  -m {undefined|no-undefined}    Execute tests according to mode\n"
					"  -p TESTPATH                    Only start test cases matching TESTPATH\n"
					"  -s TESTPATH                    Skip all tests matching TESTPATH\n"
					"  -seed=SEEDSTRING               Start tests with random seed SEEDSTRING\n"
					"  --debug-log                    debug test logging output\n"
					"  -q, --quiet                    Run tests quietly\n"
					"  --verbose                      Run tests verbosely\n", args[0]);
				
				
			}
			
			
			
		}
		
	}

}

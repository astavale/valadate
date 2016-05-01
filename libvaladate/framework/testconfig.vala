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

	public class TestConfig : Object {

		public string binary {get;set;}
		public string initial_cwd;

		public bool initialized {get;set;default=false;}
		public bool quick {get;set;default=false;}
		public bool perf {get;set;default=false;}
		public bool verbose {get;set;default=false;}
		public bool quiet {get;set;default=false;}
		public bool undefined {get;set;default=false;}

		public bool fatal_warnings {get;set;default=false;}

		public string seedstr {get;set;}

		internal bool mode_fatal {get;set;default=true;}
		internal bool debug_log {get;set;default=false;}
		internal bool tap_log {get;set;default=true;}
		internal bool in_subprocess {get;set;default=true;}
		internal bool run_list {get;set;default=false;}
		internal bool show_help {get;set;default=false;}
		
		internal int64 log_fd {get;set;}
		internal int64 startup_skip_count {get;set;}
		
		public SList<string> test_paths;
		public SList<string> test_paths_skipped;
		
		construct {
			test_paths = new SList<string>();
			test_paths_skipped = new SList<string>();
		}
		
		public TestConfig() {
			
		}
		
		public TestConfig.from_params(ref unowned string[] args) {
			
			binary = args[0];
			initial_cwd = GLib.Environment.get_current_dir();
			
			for (int i=0; i < args.length; i++) {
			
				if("--g-fatal-warnings" == args[i])
					this.fatal_warnings = true;
				
				else if("--keep-going" == args[i] || "-k" == args[i])
					this.mode_fatal = false;
					
				else if("--debug-log" == args[i])
					this.debug_log = true;
					
				else if("--tap" == args[i])
					this.tap_log = true;

				else if(args[i].index_of("--GTestLogFD") == 0) {
					if(args[i].length > 12 && args[i].data[12] == '=')
						this.log_fd = int64.parse(args[i].substring(13));
					else if (i + 1 < args.length)
						this.log_fd = int64.parse(args[++i]);
						
				}

				else if(args[i].index_of("--GTestSkipCount") == 0) {
					if(args[i].length > 16 && args[i].data[16] == '=')
						this.startup_skip_count = int64.parse(args[i].substring(17));
					else if (i + 1 < args.length)
						this.startup_skip_count = int64.parse(args[++i]);
				}
				
				else if("--GTestSubprocess" == args[i]) {
					this.in_subprocess = true;
				#if HAVE_SYS_RESOURCE_H
					// resource limit check and set rlimit
					setrlimit (RLIMIT_CORE, { 0, 0 });
				#endif
					
				}

				
				else if(args[i].index_of("-p") == 0) {
					if(args[i].length > 2 && args[i].data[2] == '=')
						this.test_paths.prepend(args[i].substring(3));
					else if (i + 1 < args.length)
						this.test_paths.prepend(args[++i]);
				}

				else if(args[i].index_of("-s") == 0) {
					if(args[i].length > 2 && args[i].data[2] == '=')
						this.test_paths_skipped.prepend(args[i].substring(3));
					else if (i + 1 < args.length)
						this.test_paths_skipped.prepend(args[++i]);
				}
				
				else if(args[i].index_of("-m") == 0) {
					string mode = "";
					if(args[i].length > 2 && args[i].data[2] == '=')
						mode = args[i].substring(3);
					else if (i + 1 < args.length)
						mode = args[++i];
					
					switch (mode) {
						case "perf":
							this.perf = true;
							break;
						case "slow":
							this.quick = false;
							break;
						case "thorough":
							this.quick = false;
							break;
						case "quick":
							this.quick = true;
							this.perf = false;
							break;
						case "undefined":
							this.undefined = true;
							break;
						case "no-undefined":
							this.undefined = false;
							break;
						default:
							// throw ("unknown test mode: -m %s", mode);
							break;
					
					}
				}
				
				else if("--quiet" == args[i] || "-q" == args[i]) {
					this.quiet = true;
					this.verbose = false;
				}
		
				else if("--verbose" == args[i] || "-v" == args[i]) {
					this.quiet = false;
					this.verbose = true;
				}
				
				else if("-l" == args[i])
					this.run_list = true;

				else if("--help" == args[i] || "-h" == args[i] || "-?" == args[i])
					this.show_help = true;


				else if(args[i].index_of("--seed") == 0)
					if(args[i].length > 6 && args[i].data[6] == '=')
						this.seedstr = args[i].substring(7);
					else if (i + 1 < args.length)
						this.seedstr = args[++i];
				
			}
			
		}
		
	}

}

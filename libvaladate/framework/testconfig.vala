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
		
		public bool initialized {get;set;default=false;}
		public bool quick {get;set;default=false;}
		public bool perf {get;set;default=false;}
		public bool verbose {get;set;default=false;}
		public bool quiet {get;set;default=false;}
		public bool undefined {get;set;default=false;}

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
		
	}

}

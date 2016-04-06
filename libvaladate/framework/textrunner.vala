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

	using Valadate.Introspection;


	public errordomain RunError {
		MODULE,
		GIR,
		TESTS,
		METHOD
	}

	public class TextRunner : Object, TestRunner {
		
		public delegate Object CreateTestObject();
		public delegate void TestMethod(Framework.TestCase self);
		public delegate void AsyncTestMethod(Framework.TestCase self, AsyncReadyCallback cb);
		public delegate void AsyncTestMethodResult(Framework.TestCase self, AsyncResult res);
		
		private string path;
		private Test[] _tests;
		
		public Test[] tests {
			get {
				return _tests;
			}
		}
		
		public TestConfig config {get;set;}
		
		public TestResult result {get;set;default=new TestResult();}
		
		public TextRunner(TestConfig config) {
			this.config = config;
			this.path = config.binary;
		}
		
		public void run(Test? test = null) {
			if (test != null)
				if ((test in _tests) == false)
					_tests += test;
			
			if(this.path != null)
				load();
			
			foreach(Test _test in _tests) {
				if (config.run_list) {
					print("%s\n", ((TestCase)_test).name);
				}
			}
		}

		
		public void load() throws RunError {
			if(path == null)
				throw new RunError.MODULE("No test binary found");
			
			if(_tests.length > 0)
				return;
			
			string girdir = Path.get_dirname(path).replace(".libs", "");
			string girfile = girdir + GLib.Path.DIR_SEPARATOR_S + 
				Path.get_basename(path).replace("lt-","") + ".gir";
			try {
				Repository.add_package(path, girfile);
				
				// Check for:
				// TestConfig
				// TestResult
				// Load and run
				// TestSuite
				// TestCase
				// Sub Classes
				
				
				load_tests();
			} catch (Valadate.Introspection.Error e) {
				throw new RunError.MODULE(e.message);
			}
		}
		
		
		internal class AsyncMethod {
			public Method begin;
			public Method end;
		}
		
		internal void load_tests() throws RunError {
			Class[] testclasses = Repository.get_class_by_type(typeof(Framework.TestCase));

			foreach (Class testcls in testclasses) {
				if (testcls.abstract)
					continue;

				var test = testcls.get_instance() as Framework.TestCase; 
				test.name = testcls.name;

				foreach (var an in testcls.annotations)
					if (an.key.has_prefix("test.name"))
						test.name = an.value;
				
				_tests += test;

				HashTable<string,AsyncMethod> async_tests = 
					new HashTable<string,AsyncMethod>(str_hash, str_equal);

				foreach (Method method in testcls.get_methods()) {
					int timeout = 200;
					string method_name = method.name.has_prefix("test_") ?
						method.name.substring(5) : method.name;
					method_name = method.name.has_prefix("_test_") ?
						method.name.substring(6) : method_name;
					unowned TestMethod testmethod = null;
					
					// The simple use case
					if (method.annotations.length == 0 &&
						method.parameters == null) {
						if (method.name.has_prefix("test_")) {
							testmethod = (TestMethod)testcls.get_method(method.identifier);
						}
						
						if (method.name.has_prefix("_test_")) {
							testmethod = ()=> { GLib.Test.skip(@"Skipping Test $(method_name)"); };
						}
					}

					foreach (Annotation ano in method.annotations) {

						if (!ano.key.has_prefix("test."))
							break;

						if (ano.key == "test.name")
							method_name = ano.value;

						if (ano.key == "test.skip" && ano.value == "yes") {
							testmethod = ()=> { GLib.Test.skip(@"Skipping Test $(method_name)"); };
							break;
						}

						// need to check for null return value
						if (method.parameters == null) {
							testmethod = (TestMethod)testcls.get_method(method.identifier);
							continue;
						}
						
						if (ano.key == "test.timeout")
							timeout = int.parse(ano.value);
						
						if(method.parameters != null && ano.key == "test.name") {
							testmethod = null;

							if(!async_tests.contains(method_name))
								async_tests.set(method_name, new AsyncMethod());
							
							AsyncMethod methods = async_tests.get(method_name);
							
							if(method.parameters[0].name == "_res_")
								methods.end = method;
							else
								methods.begin = method;
							
							if (methods.begin != null && methods.end != null) {
								
								unowned AsyncTestMethod tmethod = 
									(AsyncTestMethod)testcls.get_method(methods.begin.identifier);

								unowned AsyncTestMethodResult testmethodresult = 
									(AsyncTestMethodResult)testcls.get_method(methods.end.identifier);
								
								test.add_async_test(
									method_name,
									(cb) => {tmethod(test, cb);},
									(res) => {testmethodresult(test, res);},
									timeout
								);
							}
						}
					}
					if (testmethod != null)
						test.add_test(method_name, ()=> {testmethod(test); });
				}
			}
		}
		
		internal void test_trap_subprocess (string? test_path, int64 usec_timeout)
			throws RunError
		{


			/* Sanity check that they used GTestSubprocessFlags, not GTestTrapFlags */
			//g_assert ((test_flags & (G_TEST_TRAP_INHERIT_STDIN | G_TEST_TRAP_SILENCE_STDOUT | G_TEST_TRAP_SILENCE_STDERR)) == 0);
/*
			if (test_path) {
				if (!g_test_suite_case_exists (g_test_get_root (), test_path))
					g_error ("g_test_trap_subprocess: test does not exist: %s", test_path);
			} else {
				test_path = test_run_name;
			}

			if (g_test_verbose ())
				g_print ("GTest: subprocess: %s\n", test_path);

			test_trap_clear ();
			test_trap_last_subprocess = g_strdup (test_path);


			var argv = new Array<string>();
			argv.add(config.binary);
			argv.add("-q");
			argv.add("-p");
			argv.add(test_path);
			argv.add("--GTestSubprocess");


			if (conf.log_fd != -1) {
				char[128] log_fd_buf;
				argv.add("--GTestLogFD");

				g_snprintf (log_fd_buf, sizeof (log_fd_buf), "%d", test_log_fd);

				argv.add(log_fd_buf.to_string);
			}

			var flags = SpawnFlags.DO_NOT_REAP_CHILD;


			if (test_flags & G_TEST_TRAP_INHERIT_STDIN)
				flags |= SpawnFlags.CHILD_INHERITS_STDIN;

			int stdout_fd, stderr_fd;
			Pid pid;

			try {
				Process.spawn_async_with_pipes (
					test_initial_cwd,
					argv.data, null, flags,
					null, null,	out pid, null, out stdout_fd, out stderr_fd);
			} catch (SpawnError e) {
				error ("test_trap_subprocess() failed: %s\n", error.message);
			}

			wait_for_child (pid,
			stdout_fd, !!(test_flags & G_TEST_SUBPROCESS_INHERIT_STDOUT),
			stderr_fd, !!(test_flags & G_TEST_SUBPROCESS_INHERIT_STDERR),
			usec_timeout);*/
		}
		
		
		
		
		
	}



}

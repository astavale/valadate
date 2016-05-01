/* testcase.vala
 * Copyright (C) 2016 Chris Daley
 * Copyright (C) 2009-2012 Julien Peeters
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.

 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.

 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Authors:
 * 	Chris Daley <chebizarro@gmail.com>
 * 	Julien Peeters <contact@julienpeeters.fr>
 */

namespace Valadate.Framework {
	
	using Valadate.Utils;
	
	/**
	 * TestCase is an abstract class that acts as a parent for unit test
	 * classes. A TestCase may contain a single test method or be a test
	 * fixture containing multiple tests. A TestCase may be run directly
	 * by calling run().
	 * 
	 * More commonly, a TestRunner runs a TestCase by calling run(TestResult),
	 * passing in a TestResult object to collect the results. The method run_test()
	 * can be overridden by subclasses of TestCase to implement a test class
	 * with a single test method. Alternatively, an instance of TestCase can
	 * be created with a name corresponding to the name of a test method.
	 * 
	 * The default implementation of run_test() uses reflection to invoke the
	 * named test method. This allows a TestCase to have multiple test methods.
	 * The following code snippet runs the test method
	 * BookTest.testBookTitle():
	 * 
	 * TestCase test = new BookTest("testBookTitle");
	 * TestResult result = test.run();
	 * 
	 * Whichever way the test methods are run, TestCase ensures test isolation
	 * by running set_up() prior to the test method and tear_down( ) afterwards.
	 * 
	 * Hamill, Paul (2004-11-02). Unit Test Frameworks: Tools for High-Quality
	 * Software Development (Kindle Locations 2821-2834). O'Reilly Media. Kindle Edition. 
	 */
	public abstract class TestCase : Object, Test, TestFixture {

		public GLib.TestSuite _suite;

		public GLib.TestSuite suite {
			get {
				if (_suite == null)
					_suite = new GLib.TestSuite (this.name);
				return _suite;
			}
		}

		public string name {get;set;} 

		private Adaptor[] adaptors = new Adaptor[0];

		private HashTable<string, Adaptor> tests =
			new HashTable<string, Adaptor> (str_hash, str_equal);

		
		construct {
			name = this.get_type().name();
			//this.suite = new GLib.TestSuite (name);
		}

		/*
		public TestCase (string? name = null)
		{
			this.name = name ?? this.get_type().name();
			this.suite = new GLib.TestSuite (this.name);
		}*/

		public void add_test (string name, owned Test.TestMethod test)
			requires (name.contains("/") != true)
		{
			var adaptor = new Adaptor (name, (owned)test, this);
			this.adaptors += adaptor;

			this.tests.insert(name, adaptor);

			this.suite.add (new GLib.TestCase (adaptor.name,
											   adaptor.set_up,
											   adaptor.run,
											   adaptor.tear_down ));
		}


		public void add_async_test (
			string name,
			owned AsyncBegin async_begin,
			owned AsyncFinish async_finish,
			int timeout = 200)
		{
			var adaptor = new Adaptor (name, () => { }, this);
			adaptor.is_async = true;
			adaptor.async_begin = (owned)async_begin;
			adaptor.async_finish = (owned)async_finish;
			adaptor.async_timeout = timeout;
			this.adaptors += adaptor;

			this.tests.insert(name, adaptor);

			this.suite.add (new GLib.TestCase (
				adaptor.name,
				adaptor.set_up,
				adaptor.run,
				adaptor.tear_down,
				sizeof(Adaptor)));

		}


		/**
		 * Runs the Tests and collects the results in a TestResult 
		 *
		 * @param result the TestResult object used to store the results of the Test
		 */
		public virtual TestResult run(TestResult? result = null) {
			return result;
		}

		public virtual TestResult run_test(Test test, TestResult? result = null) {
			return result;
		}

		public virtual void set_up () {}

		public virtual void tear_down () {}

		private class Adaptor {
			[CCode (notify = false)]
			public string name { get; private set; }
			public int async_timeout { get; set; }

			private Test.TestMethod test;
			private TestCase test_case;

			public bool is_async = false;
			public AsyncBegin async_begin;
			public AsyncFinish async_finish;

			public Adaptor (string name,
							owned Test.TestMethod test,
							TestCase test_case) {
				this.name = name;
				this.test = (owned)test;
				this.test_case = test_case;
			}

			public void set_up (void* fixture) {
				GLib.set_printerr_handler (printerr_func_stack_trace);
				Log.set_default_handler (log_func_stack_trace);
				this.test_case.set_up ();
			}

			private static void printerr_func_stack_trace (string? text) {
				if (text == null || str_equal (text, ""))
					return;

				stderr.printf (text);

				/* Print a stack trace since we've hit some major issue */
				GLib.on_error_stack_trace ("libtool --mode=execute gdb");
			}

			private void log_func_stack_trace (
				string? log_domain,
				LogLevelFlags log_levels,
				string message)	{
				Log.default_handler (log_domain, log_levels, message);

				/* Print a stack trace for any message at the warning level or above */
				if ((log_levels & (
					LogLevelFlags.LEVEL_WARNING |
					LogLevelFlags.LEVEL_ERROR |
					LogLevelFlags.LEVEL_CRITICAL)) != 0) {
					GLib.on_error_stack_trace ("libtool --mode=execute gdb");
				}
			}

			public void run (void* fixture)	{
				if (this.is_async) {
					try	{
						assert( wait_for_async (async_timeout, this.async_begin, this.async_finish) );
					}
					catch (GLib.Error err) {
						message(@"Got exception while excuting asynchronous test: $(err.message)");
						GLib.Test.fail();
					}
				} else {
					this.test();
				}
			}


			public void tear_down (void* fixture) {
				this.test_case.tear_down ();
			}
		}
	}
}

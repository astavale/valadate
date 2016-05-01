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

	/**
	 * TestResult is a class used to collect unit test results. The
	 * information collected includes a count of tests run and any failures
	 * or errors produced. Failures and errors are represented as instances
	 * of TestFailure.
	 * 
	 * A TestResult runs a Test by calling its runBare( ) method. A set of
	 * unit tests is run by creating an empty TestResult and calling
	 * run(TestResult) on each Test, passing the TestResult as a collecting
	 * parameter. At the end, the set of results is retrieved from the
	 * TestResult and reported. A TestResult also is created when the method
	 * Test.run() is used to execute a Test.
	 * 
	 * Hamill, Paul (2004-11-02). Unit Test Frameworks: Tools for
	 * High-Quality Software Development (Kindle Locations 2917-2925). O'Reilly Media. Kindle Edition. 
	 */
    public interface TestResult : Object {

		public abstract int error_count {get;internal set;}
		public abstract int failure_count {get;internal set;}
		public abstract int run_count {get;internal set;}

		public abstract void add_error(Test test);

		public abstract void add_failure(Test test);

		public abstract void report();

    }

}

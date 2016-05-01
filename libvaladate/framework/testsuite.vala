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
	 * TestSuite is a class representing a collection of Tests. Since it
	 * implements Test, it can be run just like a TestCase. When run, a
	 * TestSuite runs all the Tests it contains. It may contain both TestCases
	 * and other TestSuites.
	 * 
	 * Tests also can be added to a TestSuite using the add_test() method.
	 * 
	 * Hamill, Paul (2004-11-02). Unit Test Frameworks: Tools for
	 * High-Quality Software Development (Kindle Locations 2970-2980). O'Reilly Media. Kindle Edition. 
	 */
    public abstract class TestSuite : Object, Test {

		public abstract void add_test (Test test);

		public abstract TestResult run (TestResult? result = null);

    }

}

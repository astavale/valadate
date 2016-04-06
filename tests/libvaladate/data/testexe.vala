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
 
namespace Valadate.Framework.Tests {
	
	
	/*
	 * This is the definitive testcase implementation
	 */
	public class TestExe : TestCase {
		
		/*
		 * this is the most simple use case
		 * the name of the test will be the method name less the
		 * test_ prefix
		 */
		public void test_simple () {
			Assert.is_true(true);
		}

		/*
		 * this is the most simple use case
		 * the test will be skipped
		 * the name of the test will be the method name less the
		 * _test_ prefix
		 */
		public void _test_simple_skip () {
			Assert.is_true(false);
		}
		
		/*
		 * The [Test (name="")] annotation allows you to set the Test's name
		 * This is useful for giving tests human readable names in the output
		 */
		[Test (name="Annotated Test With Name")]
		public void annotated_test_with_name () {
			Assert.is_true(true);
		}

		/*
		 * The [Test (time=xxx)] annotation allows you to set the
		 * timeout for an async test. This has no effect on non-async tests
		 */
		[Test (name="Asynchronous Test", timeout=1000)]
		public async void test_async () throws ThreadError {
			debug("Async Test called");
			assert_true(true);
		}

		/*
		 * The [Test (skip=yes|no)] annotation allows you to skip the
		 * test. The no parameter is redundant.
		 * the name of the test will be the function name less
		 * any test_ prefix
		 */
		[Test (skip="yes")]
		public void skip_test () {
			assert_true(false);
		}
		
	}

	[Test (name="Annotated Test Class With Name")]
	public class TestExeSubClass : TestExe {

		public void test_method() {
			assert_true(true);
		}

	}
	
	
	public class MyTestConfig : TestConfig {
		
		construct {
			quick = true;
		}
	}
	
}

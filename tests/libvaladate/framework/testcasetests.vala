namespace Valadate.Framework.Tests {

	public class TestTestCase : TestCase {
		
		
	}

	void add_test_case_tests () {


		GLib.Test.add_func ("/Framework/TestCase/new", () => {
			TestCase test = new TestTestCase();
			
			assert(test is TestCase);
			assert(test.suite != null);
		});

		GLib.Test.add_func ("/Framework/TestCase/add_test", () => {
			TestCase test = new TestTestCase();
			
			test.add_test("add_test", ()=> { assert(true); });
			
			assert(test is TestCase);
		});


	}
}

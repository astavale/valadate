namespace Valadate.Framework {

	public int main (string[] args) {

		TestConfig config = new TestConfig.from_params(ref args);
		TextRunner runner = new TextRunner(config);
		TestResult result = runner.run();
		result.report();

		GLib.Test.init(ref args);
		
		/*
		try {
			runner.load();
		} catch (RunError err) {
			debug(err.message);
			return -1;
		}*/

		foreach (Test test in runner.tests)
			GLib.TestSuite.get_root().add_suite(((TestCase)test).suite);

		GLib.Test.run ();
		return 0;
		
	}
}

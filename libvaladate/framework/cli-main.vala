namespace Valadate.Framework {

	public int main (string[] args) {

		TextRunner runner = new TextRunner(args[0]);

		GLib.Test.init(ref args);
		
		try {
			runner.load();
		} catch (RunError err) {
			debug(err.message);
			return -1;
		}

		foreach (Test test in runner.tests)
			GLib.TestSuite.get_root().add_suite(((TestCase)test).suite);

		GLib.Test.run ();
		return 0;
		
	}
}

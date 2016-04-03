/*
 * Valadate - Unit testing library for GObject-based libraries.
 * (C) 2016 Chris Daley <chebizarro@gmail.com>
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

namespace Valadate.Utils {
	/**
	 * Helper class to wait for asynchronous operations.
	 * Usage example:<pre>
	 *     private PollingWait wait = new PollingWait().timeoutAfter(5, SECONDS)
	 *                                                 .pollEvery(100, MILLISECONDS);
	 *     &#64;Test
	 *     public void test_auto_complete() throws Exception {
	 *         // Enter "cheese" into auto complete field ...
	 *         ...
	 *         wait.{@link #until(RunnableAssert) until}(new {@link RunnableAssert}("'cheesecake' is displayed in auto-complete &lt;div&gt;") {
	 *             &#64;Override
	 *             public void run() throws Exception {
	 *                 WebElement autoCompleteDiv = driver.findElement(By.id("auto-complete"));
	 *                 assertThat(autoCompleteDiv, isVisible());
	 *                 assertThat(autoCompleteDiv, containsText("cheesecake"));
	 *             }
	 *         });
	 *     }
	 * </pre>
	 * Since version 2.0 you can also use a lambda expression or a method reference instead of
	 * a {@link RunnableAssert} like this:
	 * <pre>
	 *     private PollingWait wait = new PollingWait().timeoutAfter(5, SECONDS)
	 *                                                 .pollEvery(100, MILLISECONDS);
	 *
	 *     &#64;Test
	 *     public void test_login() throws Exception {
	 *         // Enter credentials into login form ...
	 *         clickOnButton("Login");
	 *         wait.{@link #until(java.util.concurrent.Callable) until}(() -&gt; webDriver.findElement(By.linkText("Logout")).isDisplayed());
	 *         ...
	 *     }
	 *
	 *     protected void clickOnButton(String label) {
	 *         WebElement button = findButton(label);
	 *         wait.{@link #until(java.util.concurrent.Callable) until}(button::isDisplayed);
	 *         button.click();
	 *     }
	 * </pre>
	 */
	public class PollingWait : Object {

		private long timeoutMillis = 30000;
		private long pollIntervalMillis = 50;

		/**
		 * Default: 30 seconds.
		 */
		public PollingWait timeout_after(long timeAmount, TimeSpan timeUnit)
			requires (timeAmount > 0)
		{
			timeoutMillis = timeUnit;
			return this;
		}

		/**
		 * Default: 50 milliseconds.
		 */
		public PollingWait poll_every(long timeAmount, TimeSpan timeUnit) {
			requires (timeAmount > 0)
			pollIntervalMillis = timeUnit;
			return this;
		}

		/**
		 * Repetitively executes the given <code>runnableAssert</code>
		 * until it succeeds without throwing an {@link Error} or
		 * {@link Exception} or until the configured {@link #timeoutAfter timeout}
		 * is reached, in which case an {@link AssertionError} will be thrown.
		 * Calls {@link Thread#sleep} before each retry using the configured
		 * {@link #pollEvery interval} to free the CPU for other threads/processes.
		 */
		public void until(@Nonnull RunnableAssert runnableAssert) {
			ArrayList<Throwable> errors = new ArrayList<>();
			long startTime = System.currentTimeMillis();
			long timeoutReached = startTime + timeoutMillis;
			boolean success = false;
			do {
				try {
					runnableAssert.run();
					success = true;
				} catch (Throwable t) {
					if (errors.size() > 0 && startTime > timeoutReached) {
						StringBuilder sb = new StringBuilder();
						sb.append(runnableAssert);
						sb.append(" did not succeed within ");
						appendNiceDuration(sb, timeoutMillis);
						appendErrors(sb, errors, t);
						throw new AssertionError(sb.toString());
					}
					if (errors.size() < 2) {
						errors.add(t);
					}
					long sleepTime = pollIntervalMillis - (System.currentTimeMillis() - startTime);
					if (sleepTime > 0) {
						sleep(sleepTime);
					}
					startTime = System.currentTimeMillis();
				}
			} while (!success);
		}

		/**
		 * Repetitively executes the given <code>Callable&lt;Boolean&gt;</code>
		 * until it returns <code>true</code> or until the configured
		 * {@link #timeoutAfter timeout} is reached, in which case an
		 * {@link AssertionError} will be thrown. Calls {@link Thread#sleep}
		 * before each retry using the configured {@link #pollEvery interval}
		 * to free the CPU for other threads/processes.
		 *
		 * @since 2.0
		 */
		public void until(@Nonnull Callable<Boolean> shouldBeTrue) {
			until(new RunnableAssert(shouldBeTrue.toString()) {
				@Override
				public void run() throws Exception {
					assertTrue(shouldBeTrue.call());
				}
			});
		}

		private void appendNiceDuration(StringBuilder sb, long millis) {
			if (millis % 60000 == 0 && millis > 60000) {
				sb.append(millis / 60000).append(" minutes");
				return;
			}
			if (millis % 1000 == 0 && millis > 1000) {
				sb.append(millis / 1000).append(" seconds");
				return;
			}
			sb.append(millis).append(" ms");
		}

		private const string EXCEPTION_SEPARATOR = "\n\t______________________________________________________________________\n";

		private void append_errors(StringBuilder sb, List<Throwable> errors, Throwable lastError) {
			sb.append(EXCEPTION_SEPARATOR);
			sb.append("\t1st error: ");
			StringWriter sw = new StringWriter();
			errors.get(0).printStackTrace(new PrintWriter(sw));
			sb.append(sw.toString().replace("\n", "\n\t").trim());
			if (errors.size() >= 2) {
				sb.append(EXCEPTION_SEPARATOR);
				sb.append("\t2nd error: ");
				sw = new StringWriter();
				errors.get(1).printStackTrace(new PrintWriter(sw));
				sb.append(sw.toString().replace("\n", "\n\t").trim());
			}
			sb.append(EXCEPTION_SEPARATOR);
			sb.append("\tlast error: ");
			sw = new StringWriter();
			lastError.printStackTrace(new PrintWriter(sw));
			sb.append(sw.toString().replace("\n", "\n\t").trim());
			sb.append(EXCEPTION_SEPARATOR);
		}

		/**
		 * Internal method, package private for testing.
		 */
		internal void sleep(long millis) {
			try {
				Thread.sleep(millis);
			} catch (InterruptedException e) {
				Thread.currentThread().interrupt();
				throw new RuntimeException("Got interrupted.", e);
			}
		}
	}
}

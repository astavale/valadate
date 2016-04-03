## Arrange >> Act >> Assert with Valadate

For Vala developers who need to test their code, Valadate is a powerful testing framework that provides behavioral, functional and unit testing features to help them write great Open Source software. Unlike other testing frameworks, Valadate is designed especially for Vala while integrating seamlessly into existing toolchains.

[![Real example](https://github.com/chebizarro/valadate/wiki/images/valadate_screenshot.png)]()

### Status
Valadate is undergoing active development, the current stable version is 1.0.0.

| Platform | Status |
| --- | --- |
| Ubuntu  15.04 | [![Build Status](http://jenkins.valadate.org:8080/buildStatus/icon?job=Valadate)](http://jenkins.valadate.org:8080/job/Valadate/) |
| Ubuntu  15.10 | [![Build Status](http://jenkins.valadate.org:8080/buildStatus/icon?job=Valadate-1.0.0 (Ubuntu-15.10))](http://jenkins.valadate.org:8080/view/Valadate/job/Valadate-1.0.0%20(Ubuntu-15.10)/) |
| Fedora  23 | [![Build Status](http://jenkins.valadate.org:8080/buildStatus/icon?job=Valadate-1.0.0 (Fedora-23))](http://jenkins.valadate.org:8080/view/Valadate/job/Valadate-1.0.0%20(Fedora-23)/) |
| Mac OS X | [![Build Status](http://jenkins.valadate.org:8080/buildStatus/icon?job=Valadate-1.0.0 (Mac OSX))](http://jenkins.valadate.org:8080/job/Valadate-1.0.0%20(Mac%20OSX)/) |

### Current Features ([Version 1.0](https://github.com/chebizarro/valadate/milestones/Version%201.0.0))

  * Automatic test discovery like JUnit or .NET testing framework.

  * Utility functions for waiting in a main loop until specified event or
    timeout occurs.

  * Support for asynchronous tests.

  * Utility functions providing temporary directory to tests.

  * Skipped tests and expected failures.
  
### Planned Features ([Version 1.1](https://github.com/chebizarro/valadate/milestones/Version%201.1.0))

  * Gherkin/Cucumber integration
  
  * GUI and CLI Test Runner
  
  * IDE Plugins
  
  * Events and notifications
  
  * Project Wizard

### Installation

#### From Source

```bash
./autogen.sh
make
# as root
make install
```

#### Debian

Add the repository's key
```
curl https://www.valadate.org/jenkins@valadate.org.gpg.key | sudo apt-key add -
```
Add the following repository to your software sources:
```
deb	https://www.valadate.org/repos/debian valadate main
```
Then you can install with:
```
apt-get update
apt-get install valadate
```

#### Fedora 23

Add the following to /etc/yum.repos.d/valadate.repo

```
[valadate]
name=valadate
baseurl=http://www.valadate.org/repos/fedora/$releasever/$basearch
repo_gpgcheck=1
gpgcheck=1
enabled=1
gpgkey=http://www.valadate.org/jenkins@valadate.org.gpg.key
```

Then run with root privileges:

```
dnf update
dnf install valadate
```

### Usage

Once correctly installed and configured, Valadate makes writing tests as simple as:

```vala
namespace MyTest {
	public class BookTest : Valadate.Framework.TestCase {

		public void test_construct_book() {
			
			// Arrange ...
			
			// Act ...
			
			// Assert ...
		}
	}
}

$ valac --library mytest-0 --gir mytest-0.gir --pkg valadate-1.0 -X -pie -X -fPIE mytest-0.vala

$ ./mtest-0

/LibraryBookTest/test_construct_book: OK
```

To run with [TAP](https://testanything.org/) output:

```
$ ./mtest-0 --tap

# random seed: R02Sddf35dad90ff6d1b6603ccb68028a4f0

1..1

# Start of LibraryBookTest tests

ok 1 /LibraryBookTest/test_construct_book

# End of LibraryBookTest tests
```

The ```[Test]``` annotation and parameters are also available for giving test classes and methods more readable names and for supporting asynchronous tests.

```vala
namespace MyTest {
	[Test (name="Annotated TestCase with name")]
	public class MyTest : Valadate.Framework.TestCase {

		[Test (name="Annotated Method With Name")]
		public void annotated_test_with_name () {
			assert_true(true);
		}


		[Test (name="Asynchronous Test", timeout=1000)]
		public async void test_async () {
			assert_true(true);
		}

		[Test (skip="yes")]
		public void skip_test () {
			assert_true(false);
		}
	}
}

$ ./mtest-0 --tap

1..3
# Start of Annotated TestCase with name tests
ok 1 /Annotated TestCase with name/Annotated Method With Name
ok 2 /Annotated TestCase with name/Asynchronous Test
ok 3 /Annotated TestCase with name/skip_test # SKIP Skipping Test skip_test
# End of Annotated TestCase with name tests

```

### Documentation

See the [Wiki](https://github.com/chebizarro/valadate/wiki) for detailed instructions on installing and setting up your toolchain with Valadate.

There are a number of sample projects available [here](https://github.com/chebizarro/valadate-examples) which showcase Valadate's features and how to use it with different toolchains and platforms. More information can be found on the relevant [Wiki page](https://github.com/chebizarro/valadate/wiki).

The Valadoc Reference Manual for the Vala API can be found [here](http://www.valadate.org/docs/valadoc/valadate/index.htm).

The Gtk-Doc Reference Manual for the C API can be found [here](http://www.valadate.org/docs/gtkdoc/html/).

### Follow

* [Blog](http://bit.ly/1UDpayV)
* Waffle backlog - [![Stories in Ready](https://badge.waffle.io/chebizarro/valadate.png?label=ready&title=Ready)](https://waffle.io/chebizarro/valadate)
* GitHub [Issues](https://github.com/chebizarro/valadate/issues) - for bug/feature requests
* IRC - #vala on GIMPnet (irc.gimp.org) - look for @bizarro

### Code of Conduct

This project adheres to the [Open Code of Conduct][code-of-conduct]. By participating, you are expected to honor this code.
[code-of-conduct]: http://todogroup.org/opencodeofconduct/#Valadate/chebizarro@gmail.com

### Acknowledgements

Valadate was originally developed by [Jan Hudec](bulb@ucw.cz) with significant contributions from [Julien Peeters](contact@julienpeeters.fr) and [Simon Busch](morphis@gravedo.de) and was most recently maintained by the [Yorba Foundation](http://yorba.org/).

Special thanks to Al Thomas and Mario Daniel for feedback and inspiration, the Vala mailing list and IRC channel for help and advice and the Vala developers and maintainers for their fantastic work. Oh and to you, for reading this far and for taking an interest in our little project. I hope you find it useful!

### Copyright

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published
by the Free Software Foundation, either version 3 of the License, or (at
your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program in the file COPYING.  You should have received
a copy of the GNU General Public License refered therein along with this
program in the file GPL-3.  If not, see <[http://www.gnu.org/licenses/](http://www.gnu.org/licenses/)>.

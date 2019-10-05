# Universal STM8 Builder

## What is it?

Universal STM8 Builder is a build script, targeting STM8 microcontrollers, that works most of the time.
It frees you from dealing with complex Makefile by offering a more simplistic one.

## Why?

It takes time for creating and maintaining a build script for each C project,
and most of them are not that much different after all.  
If a project can fit with some conventions and constraints, enable them to use a shared build script,
why bother wasting time tailor a build script just to use once?

## What are the constraints?

- Third-party libraries should be placed inside a single directory. (Default to `./vendor`)
- Application source files should be placed in `./src`.
- The build result will appear in `./bin`.
- No fancy stuff (assembly language compilation and linking, some niche debugging capabilities)
- By default, the script will not look too deep into the directory containing third-party's libraries to prevent conflicts between dependencies.

## Managing project dependencies

The dependencies of your dependencies are your dependencies.  
The build script won't look too deep into the directories of third-party libraries, leaving dependencies of dependencies alone without compiling them.  
The recommended way to manage dependencies is to have a copy of them as your direct dependencies. Allowing third-party libraries that depends on the different version of the same library to co-exist. (If the interface allows) The final decision of which version to use is yours.

## Customizability

It is recommended that you embrace the constraints, but as you may know, you can still customize your `Makefile` to your heart content,
and this script will happily getting along with yours.  
The constraints listed are not really rigid, but they lessen your works most of the time.

## The dependencies of this script

* [Small Device C Compiler](http://sdcc.sourceforge.net/) version >= 3.9.0
* [GNU Make](https://www.gnu.org/software/make/)
* [GNU Bash](https://www.gnu.org/software/bash/)

## Usages

- Include this script into your main Makefile
- Configure some variables
- Profits

[A library compilation example](https://github.com/midnight-wonderer/stm8s-tim4-periodic-timer/blob/master/Makefile)

## License

Universal STM8 Builder is released under the [MIT License](LICENSE.md). :tada:

build-tools (prev. build-tools-cpp)
===============
[![Build Status](https://travis-ci.org/deprint/build-tools-cpp.svg)](https://travis-ci.org/deprint/build-tools-cpp) [![Dependency Status](https://david-dm.org/deprint/build-tools-cpp.svg)](https://david-dm.org/deprint/build-tools-cpp) [![apm](https://img.shields.io/apm/dm/build-tools.svg)](https://github.com/deprint/build-tools-cpp) [![apm](https://img.shields.io/apm/v/build-tools.svg)](https://github.com/deprint/build-tools-cpp)

### Build your projects in atom
![Error highlighting](https://cloud.githubusercontent.com/assets/7817714/9097293/fe5026a0-3bc2-11e5-9893-04b866262e63.gif)

![Settings](https://cloud.githubusercontent.com/assets/7817714/9156632/1aa1876a-3ee1-11e5-9e95-8888a6ca433c.png)

## Features
* Execute programs/compilers in Atom
* Set up different commands for different projects
* Chain commands and projects with dependenies
* Errors are highlighted both inside the console and in-line with [Linter](https://github.com/AtomLinter/Linter)
* File coordinates are highlighted and can be opened
* Can highlight <b>GCC, Clang, Python, Java, Modelsim and apm test</b>

## Keys
* `ctrl+l ctrl+u/i/o` for executing the 1st/2nd/3rd command of a project
* `ctrl+l ctrl+l` to list all commands of a project
* `ctrl+l ctrl+,` to open per-project settings
* `ctrl+l ctrl+s` to show console output
* `ctrl+l u/i/o` lets you view and change the command before executing it

## Settings
### Commands
![Command](https://cloud.githubusercontent.com/assets/7817714/9272469/fea5afaa-4282-11e5-9640-3b56fbc57776.png)

### Dependencies
* Dependencies are executed in descending order
* <b>Commands are not executed twice</b>
* Build fails if one of the dependencies returns a non-zero exit code

## Service API
`build-tools` allows other packages to:
* add their own [highlighting profiles](https://github.com/deprint/build-tools-cpp/wiki/Service-API:-Profiles)

## Roadmap
* Project templates
* More highlighting profiles
* UI for creating simple highlighting profiles
* Service provider for other packages
* Bug fixes, UI improvements, etc.

## Contributing
* Let me know if you encounter any bugs.
* Feature requests are always welcome.

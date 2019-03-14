# Pugin Components
[Pugin Components][pugin-components] is a front-end dust component library for [beta.parliament.uk][beta]. It is built on [Shunter][shunter].

[![Build Status][shield-travis]][info-travis] [![Test Coverage][shield-coveralls]][info-coveralls] [![License][shield-license]][info-license]

### Contents
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [Requirements](#requirements)
- [Quick start](#quick-start)
- [Running the application](#running-the-application)
- [Using the Library](#using-the-library)
- [Running tests on single files or directories](#running-tests-on-single-files-or-directories)
- [i18next Note](#i18next-note)
  - [Double moustaches](#double-moustaches)
  - [Prefixing the variable name with a hyphen](#prefixing-the-variable-name-with-a-hyphen)
- [Contributing](#contributing)
- [License](#license)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Requirements
[Pugin Components][pugin-components] requires the following:
* [NodeJS][node] - [click here][node-version] for the exact version
* [NPM][npm]

## Quick start
```bash
git clone https://github.com/ukparliament/pugin-components.git
cd pugin-components
npm install
npm cache clean --force && npm test
```

## Running the application
To run the application locally, run:

```bash
make develop
```
This runs foreman that starts the app, shunter serve and watches for changes in the src directory.

The application should now be available at [http://localhost:5500][local].

## Using the Library
To use the package, you need to add it and save it into the list of dependencies in your package.json file:

```bash
npm install --save pugin-components
```

Then go to your shunter application's config (for example app.js or index.js). Add modules to the file, like the example below:
```
const app = shunter({
    path: {
        themes: __dirname
    },
    routes: config.routes,
    jsonViewParameter: 'json',
    modules: ['pugin-components']
});
```
You should now be able to call on the components as if they were in a view folder in your root directory.

## Running tests on single files or directories
The `npm run testfocus` command will let you specify a directory or file of tests to be run.

For example, to run one test:
```bash
npm run testfocus test/unit/components/card/generic.spec.js
```

Or to run a directory of tests:
```bash
npm run testfocus test/unit/components/card/
```

## i18next Note
Passing in data to the translation with double moustaches sanitises input. If you wish to pass in a URL or other data that you do not wish to be sanitised, for it be rendered correctly you must prefix the variable name with a hyphen. For example:

### Double moustaches
The following translation:
```json
"cookie-policy": "<a href='{{link}}'>Cookie Policy</a>"
```
Will be rendered incorrectly as:
```html
<a href='*&meta*&cookie'>Cookie Policy</a>
```

### Prefixing the variable name with a hyphen
The following translation:
```json
"cookie-policy": "<a href='{{-link}}'>Cookie Policy</a>"
```
Will be rendered correctly as:
```html
<a href='/meta/cookie'>Cookie Policy</a>
```

## Contributing
If you wish to submit a bug fix or feature, you can create a pull request and it will be merged pending a code review.

1. Fork the repository
1. Create your feature branch (`git checkout -b my-new-feature`)
1. Commit your changes (`git commit -am 'Add some feature'`)
1. Push to the branch (`git push origin my-new-feature`)
1. Ensure your changes are tested using [Mocha][mocha]
1. Create a new Pull Request

## License
[Pugin Components][pugin-components] is licensed under the [MIT][info-license].

[pugin-components]: https://github.com/ukparliament/pugin-components
[beta]: https://beta.parliament.uk
[shunter]: https://github.com/springernature/shunter
[pugin]: https://github.com/ukparliament/parliament.uk-pugin
[node]: https://nodejs.org/
[node-version]: https://github.com/ukparliament/pugin-components/blob/master/.node-version
[npm]: https://www.npmjs.com/
[local]: http://localhost:5500
[mocha]: https://mochajs.org/

[info-travis]:   https://travis-ci.org/ukparliament/pugin-components
[shield-travis]: https://img.shields.io/travis/ukparliament/pugin-components.svg

[info-coveralls]:   https://coveralls.io/github/ukparliament/pugin-components
[shield-coveralls]: https://img.shields.io/coveralls/ukparliament/pugin-components.svg

[info-license]:   https://github.com/ukparliament//blob/master/LICENSE
[shield-license]: https://img.shields.io/badge/license-MIT-blue.svg

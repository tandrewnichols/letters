[![Build Status](https://travis-ci.org/tandrewnichols/letters.png)](https://travis-ci.org/tandrewnichols/letters) [![downloads](http://img.shields.io/npm/dm/letters.svg)](https://npmjs.org/package/letters) [![npm](http://img.shields.io/npm/v/letters.svg)](https://npmjs.org/package/letters) [![Code Climate](https://codeclimate.com/github/tandrewnichols/letters/badges/gpa.svg)](https://codeclimate.com/github/tandrewnichols/letters) [![Test Coverage](https://codeclimate.com/github/tandrewnichols/letters/badges/coverage.svg)](https://codeclimate.com/github/tandrewnichols/letters) [![dependencies](https://david-dm.org/tandrewnichols/letters.png)](https://david-dm.org/tandrewnichols/letters)

[![NPM info](https://nodei.co/npm/letters.png?downloads=true)](https://nodei.co/npm/letters.png?downloads=true)

# letters

Iterate through sequences that include letters.

## Installation

`npm install --save letters`

## Usage

```js
var Letters = require('letters');
var letters = new Letters(/*options*/)

console.log(letters.next()); // "a"
console.log(letters.next()); // "b"
// . . .
console.log(letters.next()); // "z"
console.log(letters.next()); // "aa"
```

## Options

Some things are configurable via the options object.

### useNumbers

Include numbers in the sequence (default is false). By default, when this option is provided, numbers are included after the letters.

```js
var Letters = require('letters');
var letters = new Letters({ useNumbers: true })

console.log(letters.next()); // "a"
console.log(letters.next()); // "b"
// . . .
console.log(letters.next()); // "z"
console.log(letters.next()); // "0"
```

### numbersFirst

Include numbers and place them before letters. `useNumbers` is implied by specifying this option, so you don't need both.

```js
var Letters = require('letters');
var letters = new Letters({ numbersFirst: true })

console.log(letters.next()); // "0"
console.log(letters.next()); // "1"
// . . .
console.log(letters.next()); // "9"
console.log(letters.next()); // "a"
// . . .
console.log(letters.next()); // "z"
console.log(letters.next()); // "00"
```

### startAt

By default, the sequence begins with the first character ("a" normally, or "0" with `numbersFirst`), but you can force the sequence to begin at any point, even at a multi-letter sequence.

```js
var Letters = require('letters');
var letters = new Letters({ startAt: 'abc' })

console.log(letters.next()); // "abc"
console.log(letters.next()); // "abd"
```

## Contributing

I'll be happy to merge any pull request that adds value and has passing tests. Tests are run with `grunt`.

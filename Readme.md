# jQuery During Scroll

A script to execute arbitrary code when a user starts to scroll, during the scroll and after a scroll has completed. This is different from the default browser and jQuery behavior in that it treats the entire scroll action as one long event instead of executing hundreds of times during a single scroll action.

[![Code Climate](https://codeclimate.com/github/jacopotarantino/jquery-during-scroll/badges/gpa.svg)](https://codeclimate.com/github/jacopotarantino/jquery-during-scroll)

[![Test Coverage](https://codeclimate.com/github/jacopotarantino/jquery-during-scroll/badges/coverage.svg)](https://codeclimate.com/github/jacopotarantino/jquery-during-scroll)


## Installation

While the plugin is titled as though it's just a jQuery plugin, it is available in many formats. The plugin exposes itself as an AMD, CommonJS and jQuery plugin and exposes itself as a global "duringScroll" if none of those are found.

Include the script after jQuery and any other dependencies(such as requirejs) if you want the plugin to bind to them instead of the global context.

### Via Bower

```bash
bower install --save jquery-during-scroll
```

### Manually

Copy the file `source/jquery-during-scroll.js` into your project and reference it in a `<script>` tag at the end of the `<body>` tag in your HTML.


## API

Below is an example usage that has all the default options:

```javascript
var scrollInterval = $.duringScroll({
  interval: 60,
  always: function() {},
  scrollStart: function() {},
  duringScroll: function() {},
  afterScroll: function() {}
});
```

The function returns a reference to the interval instance so that you can kill it if need be. An example assuming you called the method as above and stored the instance in a `scrollInterval` variable:

```javascript
$('body').on('click', function() {
  clearInterval(scrollInterval);
});
```


### Options

#### interval *Number*

Defines how often we check if the user is still scrolling. It's necessary to use an interval instead of listening for the scroll event because the latter has a major performance impact. I find that around 60ms interval reliably tracks user interactions.

#### always *Function*

A callback to execute at every single `interval` invocation.

#### scrollStart *Function*

A callback to execute when we detect the user has started scrolling.

#### duringScroll *Function*

A callback to execute every `interval` milliseconds while the user is scrolling.

#### afterScroll *Function*

A callback to execute when we've detected the user is no longer scrolling.


## Tests

Tests are in the `test` folder and run on karma + jasmine.

### Requirements

* node
* npm
* Chrome

### Running

Run the command `npm install` from the terminal to get all required packages then run `npm test` to run the test suite.

Note that the default test command reports code coverage to Code Climate. Run `karma` on its own if you wish to avoid this behavior.


## License

This work is licensed under the Creative Commons Attribution-ShareAlike 4.0 International License. To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/4.0/deed.en_US.


## Contributing

* Fork the repo
* Write your tests
* Make the tests pass
* Commit your changes
* Open a pull request on this repository.

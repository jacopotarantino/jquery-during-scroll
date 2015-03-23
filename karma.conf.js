module.exports = function(config) {
  config.set({

    // base path, that will be used to resolve files and exclude
    basePath: './',

    // frameworks to use
    frameworks: ['jasmine'],

    // list of files / patterns to load in the browser
    files: [
      'test/support/boot.js',
      'source/during-scroll.js',
      'test/jquery-during-scroll_test.coffee'
    ],

    // test results reporter to use
    reporters: ['progress', 'dots', 'coverage'],

    preprocessors: {
      // source files, that you wanna generate coverage for
      // do not include tests or libraries
      // (these files will be instrumented by Istanbul)
      'source/during-scroll.js': ['coverage'],
      '**/*.coffee': ['coffee']
    },

    coffeePreprocessor: {
      // options passed to the coffee compiler
      options: {
        bare: true,
        sourceMap: true
      },
      // transforming the filenames
      transformPath: function(path) {
        return path.replace(/\.coffee$/, '.js');
      }
    },

    // optionally, configure the reporter
    coverageReporter: {
      type : 'html',
      dir: 'coverage/',
      reporters: [
        {
          type : 'html',
          subdir : 'report-html'
        },
        {
          type : 'lcov',
          subdir : 'report-lcov'
        }
      ]
    },

    // web server port
    port: 9876,

    // enable / disable colors in the output (reporters and logs)
    colors: true,

    // level of logging
    logLevel: config.LOG_INFO,

    // enable / disable watching file and executing tests whenever any file changes
    autoWatch: true,

    // Start these browsers
    browsers: ['Chrome'],

    // If browser does not capture in given timeout [ms], kill it
    captureTimeout: 60000,

    captureConsole: false,

    hostname: 'localhost',

    // Continuous Integration mode
    // if true, it capture browsers, run tests and exit
    singleRun: true
  });
};

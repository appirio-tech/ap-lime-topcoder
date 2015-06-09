'use strict'

module.exports = (config) ->

  config.set
    # enable / disable watching file and executing tests whenever any file changes
    autoWatch: true

    # base path, that will be used to resolve files and exclude
    basePath: '../'

    # testing framework to use (jasmine/mocha/qunit/...)
    frameworks: ['mocha', 'chai', 'sinon']

    # list of files / patterns to load in the browser
    files: [
      # bower:js
      'bower_components/jquery/dist/jquery.js'
      'bower_components/angular/angular.js'
      'bower_components/angular-cookies/angular-cookies.js'
      'bower_components/angular-jwt/dist/angular-jwt.js'
      'bower_components/angular-sanitize/angular-sanitize.js'
      'bower_components/angular-ui-router/release/angular-ui-router.js'
      'bower_components/bootstrap/dist/js/bootstrap.js'
      'bower_components/angular-bootstrap/ui-bootstrap.js'
      'bower_components/angular-dropdowns/angular-dropdowns.js'
      'bower_components/angular-scroll/angular-scroll.js'
      'https://cdn.auth0.com/w2/auth0-1.6.4.js'
      'https://app-abc.marketo.com/js/forms2/js/forms2.min.js'
      'bower_components/angular-mocks/angular-mocks.js'
       # endbower
      'app/app.coffee'
      'app/directives/checkbox.coffee'
      'app/directives/*.coffee'
      'app/*.coffee'
      'app/**/*.coffee'
      'test/mock/**/*.coffee'
      'test/spec/**/*.coffee'
      'test/spec/**/*.json'
    ]

    # list of files / patterns to exclude
    exclude: [
    ]

    # web server port
    port: 8080

    # // Start these browsers, currently available:
    # // - Chrome
    # // - ChromeCanary
    # // - Firefox
    # // - Opera
    # // - Safari (only Mac)
    # // - PhantomJS
    # // - IE (only Windows)
    browsers: [
      'PhantomJS'
    ]

    # Which plugins to enable
    plugins: [
      'karma-phantomjs-launcher'
      'karma-mocha'
      'karma-chai'
      'karma-sinon'
      'karma-coffee-preprocessor'
    ]

    preprocessors: '**/*.coffee': ['coffee']

    coffeePreprocessor:
      options:
        bare: false
        sourceMap: false
      transformPath: (path) ->
        path.replace(/\.coffee$/, '.js')

    # // Continuous Integration mode
    # // if true, it capture browsers, run tests and exit
    singleRun: true

    colors: true

    # // level of logging
    # // possible values: LOG_DISABLE || LOG_ERROR || LOG_WARN || LOG_INFO || LOG_DEBUG
    logLevel: config.LOG_INFO

    # Uncomment the following lines if you are using grunt's server to run the tests
    proxies: '/base/.tmp': 'http://localhost:9000'
    # URL root prevent conflicts with the site root
    # urlRoot: '_karma_'

